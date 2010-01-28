{-# LANGUAGE UndecidableInstances, FlexibleInstances, OverlappingInstances, TypeOperators #-}
module Merging
    where

import IO
import Control.Applicative
import Control.Concurrent
import Control.Exception
import System.IO.Unsafe
import Data.Ord
import Data.Monoid -- just for kicks
import Data.List
import Data.Maybe
import qualified Data.Map as Map
import Debug.Trace


-- Lattices (actually, join semi-lattices)

-- join is commutative, associative, and idempotent.
-- Some lattices do not have bounds.
class UnboundedJoinLattice a where
    join :: a -> a -> a

-- zero is the identity for join
-- join one x = join x one = one.
class UnboundedJoinLattice a => JoinLattice a where
    zero :: a
    one  :: a

-- Lattices have products
instance (UnboundedJoinLattice a, UnboundedJoinLattice b) => UnboundedJoinLattice (a,b) where
    (a1,b1) `join` (a2,b2) = (a1 `join` a2, b1 `join` b2)

instance (JoinLattice a, JoinLattice b) => JoinLattice (a,b) where
    zero = (zero, zero)
    one  = (one,  one)

-- There is a natural lattice structure on functions into a lattice
instance UnboundedJoinLattice b => UnboundedJoinLattice (a -> b) where
    join f g x = join (f x) (g x)

instance JoinLattice b => JoinLattice (a -> b) where
    zero = const zero
    one  = const one

-- Lattices form monoids
instance JoinLattice a => Monoid a where
    mappend = join
    mempty  = zero

-- One can add artificial bounds to an existing lattice
data Bounds a = Zero | Elt a | One deriving (Show, Eq)

instance UnboundedJoinLattice a => UnboundedJoinLattice (Bounds a) where
    join Zero x = x
    join x Zero = x
    join One _  = One
    join _ One  = One
    join (Elt x) (Elt y) = Elt $ x `join` y

instance UnboundedJoinLattice a => JoinLattice (Bounds a) where
    zero = Zero
    one  = One

-- One can make a trivial lattice out of anything eq-comparable.
-- (This corresponds to the "all-or-nothing" information type).
data FlatLattice a = FZero | Flat a | FOne deriving (Show, Eq)

instance Eq a => UnboundedJoinLattice (FlatLattice a) where
    -- TODO Is there a way to remove this code duplication?
    join FZero x = x
    join x FZero = x
    join FOne _  = FOne
    join _ FOne  = FOne
    join (Flat x) (Flat y) | x == y    = Flat x
                           | otherwise = FOne

instance Eq a => JoinLattice (FlatLattice a) where
    zero = FZero
    one  = FOne    

-- The real numbers under max form a perfectly good example lattice
-- This could produce "Overlapping instances" errors
instance Real a => UnboundedJoinLattice a where
    join = max

-- As do the (positive) integers under divisibility
data Div a = Div a deriving (Show, Eq)

instance Integral a => UnboundedJoinLattice (Div a) where
    (Div n) `join` (Div m) = Div $ n `lcm` m

instance Integral a => JoinLattice (Div a) where
    zero = Div 1
    one  = Div 0

-- Partially ordered sets

type POrdering = Maybe Ordering

class Poset a where
    pcompare :: a -> a -> POrdering

    pleq :: a -> a -> Bool
    a `pleq` b = acb == Just EQ || acb == Just LT where
        acb = a `pcompare` b

instance (Eq a, JoinLattice a) => Poset a where
    pcompare a b | a == b     = Just EQ
                 | a == ajb   = Just GT
                 | b == ajb   = Just LT
                 | otherwise  = Nothing
                 where ajb = a `join` b

instance Poset a => Eq a where
    a == b = (a `pcompare` b) == Just EQ

-- Any totally ordered set can be thought of as a Poset
data TotalOrder a = Tot a deriving (Show, Eq)

instance Ord a => Poset (TotalOrder a) where
    pcompare (Tot x) (Tot y) = Just $ compare x y

-- Any poset can be latticified by introducing symbolic joins
-- (i.e. maintaining an upper envelope)
data Envelope a = En [a] deriving (Show)

instance Eq a => Eq (Envelope a) where
    (En xs) == (En ys) =
        xs \\ ys == [] &&
        ys \\ xs == []

instance Poset a => UnboundedJoinLattice (Envelope a) where
    (En a) `join` (En b) = En (reduce (a ++ b)) where
        -- TODO This repeats the work of reducing a and b, which are
        -- presumably already reduced.
        reduce :: (Poset a) => [a] -> [a]
        reduce lst =
            case lst of
              [] -> []
              x:xs | any (x `pleq`) xs -> reduce xs
                   | otherwise         -> x:(reduce $ filter (not . (`pleq` x)) xs)

instance Poset a => JoinLattice (Envelope a) where
    zero = En []
    one  = undefined -- The list of all the top elements of the poset

-- Improving values

-- I appear to be screwed because I kind of want Improving a to imply
-- that a is a JoinLattice; but I can't seem to turn Improving into an
-- instance of classes like Functor, Applicative, and Monad with a
-- restriction on a.
data Improving a = Imp [a] deriving (Show)

unImp :: Improving a -> [a]
unImp (Imp x) = x

-- without the zero of the lattice you can do this:
joinify1 :: JoinLattice a => Improving a -> Improving a
joinify1 = Imp . scanl1 join . unImp
-- but the following is nice because it "primes the pump"
-- with the lattice's zero.
joinify :: JoinLattice a => Improving a -> Improving a
joinify = Imp . scanl join zero . unImp

joinify2 :: JoinLattice a => Improving a -> a
joinify2 = foldr1 join . unImp

-- Drops all readily-available elements in the input stream; retains
-- stopping points of, e.g., a stream generated by another thread.
-- Semantically appropriate only for streams that have been joinified,
-- but I'm too lazy to express that in the type system just yet.
drop_eager :: [a] -> [a]
drop_eager lst = 
    case lst of
      []   -> []
      x:xs -> drop_eager' x xs

-- The job of drop_eager' is to hold on to the value it has already
-- discovered and check whether there's another value readily
-- available.  If there is, drop the first value and immediately recur
-- with the new available one.  If not, emit the remembered value and
-- recur into drop_eager, to wait for the next one.

-- The naive implementation of drop_eager', below, doesn't work,
-- because the first alternative must communicate success to the unamb
-- call when it *occurs*, not when it eventually finds itself emitting
-- an element.
--
-- drop_eager' elt lst =
--     (drop lst) `unamb` (keep lst)
--     where
--       drop []     = [elt]
--       drop (x:xs) = drop_eager' x xs
--       keep lst = unsafePerformIO $ stall $ elt:drop_eager lst
--       stall x = do threadDelay 10 -- some short time
--                    return x
--
-- In its place, I write this horrible hack, which includes a spurious
-- immediately discarded piece of list structure as a device for
-- communicating to unamb.
{-# NOINLINE drop_eager' #-} -- because of unsafePerformIO
drop_eager' elt lst =
    tail $ trace "unamb in drop_eager" $ (drop lst) `unamb` (keep lst)
    where
      drop []     = trace "drop done" [elt, elt]
      drop (x:xs) = trace "drop wins" $ elt:(drop_eager' x xs)
      keep lst = unsafePerformIO $ stall $ trace "keep wins" $ elt:elt:drop_eager lst
      stall x = do threadDelay 10 -- some short time
                   return x

-- It turns out that there *is* a reason to remember the "already
-- joinified" property in the type system: It allows me to implicitly
-- joinify streams of functions, which would otherwise be impossible
-- to deal with because functions are not in the Eq typeclass in
-- Haskell.

-- The choice of which list to take the head of is made as soon as it
-- is known which list *has* a head (not necessarily what it is).
-- Therefore, for this to work, the input lists need to always be in a
-- state of possible termination (as produced by, e.g., filter).
-- This can be changed by writing (cons $! x mumble)
merge :: Improving a -> Improving a -> Improving a
merge (Imp xlst) (Imp ylst) =
    Imp $ trace "unamb in merge" $ (pull_from xlst ylst) `unamb` (pull_from ylst xlst)
    where
      pull_from []     ys = ys
      pull_from (x:xs) ys = trace "won" x:unImp(Imp xs `merge` Imp ys)

{-# NOINLINE unamb #-} -- because of unsafePerformIO
unamb :: a -> a -> a
a `unamb` b = unsafePerformIO (a `amb` b)

-- amb has a direct implementation in terms of forkIO as follows:
amb :: a -> a -> IO a
-- a `amb` b = evaluate a `race` evaluate b

race :: IO a -> IO a -> IO a
a `race` b =
    do v <- newEmptyMVar
       ta <- forkIO (a >>= putMVar v)
       tb <- forkIO (b >>= putMVar v)
       x <- readMVar v
       killThread ta
       killThread tb
       return x

-- amb also has an implementation in terms of mergeIO, which does
-- different things with its threads internally.  I had hoped that
-- those different things would control the subthreads so that they do
-- not run away, and that this would fix my infinite loop; but either
-- one or the other (or both) of these hopes did not come to pass.
a `amb` b = 
    (strict_list a) `mergeIO` (strict_list b) >>= (return . head) where
        strict_list x = seq x [x]
-- This doesn't work because mergeIO makes decisions based on the
-- availability of the list structure, not the elements in it, and
-- therefore always turns left.
-- a `amb` b = [a] `mergeIO` [b] >>= (return . head)


instance Functor Improving where
    -- f should be a lattice homomorphism
    fmap f (Imp a) = Imp (map f a)

-- I'm having a lot of trouble with Applicative because the
-- non-Eq'ness of functions impairs both lattices over functions and
-- Improving lattices over functions.

instance Applicative Improving where
    pure x = Imp [x]
    a <*> b = fmap applyPair $ mergeCross a b

applyPair (f,x) = f x

-- I want to write:
-- mergeCross :: (JoinLattice a, JoinLattice b) => Improving a -> Improving b -> Improving (a,b)
-- mergeCross a b =
--     joinify $ (fmap injectL a) `merge` (fmap injectR b)
--     where
--       injectL a = (a,zero)
--       injectR b = (zero,b)
-- but I lose, partly because join is actually a relatively expensive
-- operation on functions, and partly because I haven't yet figured
-- out how to make instance Applicative Improving be dependent on the
-- context that the types being improved are JoinLattices.  That
-- problem may be solvable by existential types, or GADTs, or
-- higher-rank types, or, in general, a careful reading of the type
-- system extensions listed in the GHC manual.

mergeCross :: Improving a -> Improving b -> Improving (a,b)
mergeCross (Imp []) _ = (Imp []) -- TODO Really? Or can I use the zero of the lattice?
mergeCross _ (Imp []) = (Imp [])
mergeCross (Imp (x:xs)) (Imp (y:ys)) =
    Imp ((x,y):(mergeHelp x y xs ys)) where
        mergeHelp x y xs ys = trace "unamb in mergeCross" $ 
            (pull_from_xs xs) `unamb` (pull_from_ys ys)
                where
                  pull_from_xs []       = trace "xs done" $ map (\y -> (x,y)) ys
                  pull_from_xs (x':xs') = trace "xs win"  $ (x',y):(mergeHelp x' y xs' ys)
                  pull_from_ys []       = trace "ys done" $ map (\x -> (x,y)) xs
                  pull_from_ys (y':ys') = trace "ys win"  $ (x,y'):(mergeHelp x y' xs ys')

-- I'm having a lot of trouble with Monad because this implementation
-- threatens to spew out huge numbers of threads

instance Monad Improving where
    x >>= f = -- joinify2 (fmap f x)
        flatten $ fmap f x
            where
              -- flatten :: JoinLattice a => Improving (Improving a) -> Improving a
              flatten (Imp iia) = 
                  case iia of
                    [] -> Imp []
                    ia:ias -> ia `merge` (flatten $ Imp ias)

    return x = Imp [x]

instance UnboundedJoinLattice (Improving a) where
    join = merge

instance JoinLattice a => JoinLattice (Improving a) where
    zero = Imp [zero]
    one  = Imp [one]    

-- loeb copied from sigfpe
-- http://blog.sigfpe.com/2006/12/tying-knots-generically.html
loeb :: Functor a => a (a x -> x) -> a x
-- Except that the definition given in the text:
-- loeb x = fmap (\a -> a (loeb x)) x
-- does not actually yield a circular data structure; but that bug is
-- fixable:
loeb x = result where result = fmap (\a -> a result) x

fmerge :: (a -> Improving b) -> (a -> Improving b) -> a -> Improving b
fmerge f g = \a -> (f a) `merge` (g a)

instance Functor FlatLattice where
    fmap _ FZero = FZero
    fmap _ FOne  = FOne
    fmap f (Flat x) = Flat $ f x

instance Applicative FlatLattice where
    pure = Flat
    FZero <*> _ = FZero
    _ <*> FZero = FZero
    FOne <*> _  = FOne
    _ <*> FOne  = FOne
    (Flat f) <*> (Flat x) = Flat $ f x 

-- Type composition from Elliot's Push-Pull FRP paper
newtype (h `Compose` g) a = O (h (g a)) deriving (Show, Eq)

instance (Functor h, Functor g) => Functor (h `Compose` g) where
    fmap f (O hga) = O (fmap (fmap f) hga)
instance (Applicative h, Applicative g) => Applicative (h `Compose` g) where
    pure a          = O(pure (pure a))
    O hgf <*> O hgx = O(liftA2 (<*>) hgf hgx)

-- I also seem to have the (putative) bug that all my cells will need
-- to hold the same types of contents (because Map values are
-- homogeneous).  That might be solvable.

-- How the heck do I abstract these constructions to be able to define
-- 'sum_constraint'?
-- Answer: sum_constraint will be an equation-set-transformer; and only one
-- loeb instance will be applied at the end.

up_merge :: ((Improving `Compose` a) b) -> ((Improving `Compose` a) b) -> ((Improving `Compose` a) b)
up_merge (O foo) (O bar) = O(foo `merge` bar)

imp_drop_eager :: Improving a -> Improving a
imp_drop_eager (Imp xs) = Imp $ drop_eager xs

up_joinify :: JoinLattice (a b) => ((Improving `Compose` a) b) -> ((Improving `Compose` a) b)
up_joinify (O foo) = O $ joinify1 foo

up_drop_eager (O foo) = O $ imp_drop_eager foo

up_nub (O (Imp xs)) = O $ Imp $ nub xs

cellify = up_drop_eager . up_nub . up_joinify

ain = pure 3
bin = pure 4
totalin :: (Improving `Compose` FlatLattice) Integer
totalin = O(Imp [FZero])

-- This produces an infinite pile of merges and drop_eagers, and never
-- spits out an answer.  Maybe this is because unamb needs to kill
-- *all* subordinate threads when it makes a decision.  Or maybe this
-- is because there is no quiescence detector: it just keeps computing
-- additions and subtractions forever, producing infinite streams of
-- Flat 7, Flat 3, and Flat 4.  The latter hypothesis is reinforced by
-- the effect of inserting up_nub into the definition of cellify,
-- above; said effect being to produce a hang instead of a buzz.
-- (In the interpreter, the hang follows after successfully printing
-- "O (Imp [FZero,Flat 7" (note the absence of close parens)).
-- N.B. Fiddling with where to sprinkle the cellifys affects the loop
-- detector's reactions to this program, but I haven't found a variant
-- that makes it stop with the answer I am looking for.
equations = Map.fromList
    [ ("total", \n -> cellify $ cellify (pure (+) <*> (lookup "a" n)     <*> (lookup "b" n)) `up_merge` totalin),
      ("a",     \n -> cellify $ cellify (pure (-) <*> (lookup "total" n) <*> (lookup "b" n)) `up_merge` ain),
      ("b",     \n -> cellify $ cellify (pure (-) <*> (lookup "total" n) <*> (lookup "a" n)) `up_merge` bin)
    ] where lookup x = trace ("looking up " ++ x) $ Map.findWithDefault (O $ pure zero) x

-- This version works
equations' = Map.fromList
    [ ("total", \n -> cellify (pure (+) <*> (lookup "a" n)     <*> (lookup "b" n)) `up_merge` totalin),
      ("a",     \n -> ain),
      ("b",     \n -> bin)
    ] where lookup x = trace ("looking up " ++ x) $ Map.findWithDefault (O $ pure zero) x

network :: Map.Map String ((Improving `Compose` FlatLattice) Integer)
network  = loeb equations
aout     = fromJust $ Map.lookup "a" network
bout     = fromJust $ Map.lookup "b" network
totalout = fromJust $ Map.lookup "total" network

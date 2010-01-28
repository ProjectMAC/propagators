module MergingTest
    where

import System.IO.Unsafe
import Control.Concurrent
import Merging
import Data.List
import Test.QuickCheck
import qualified Control.Monad as Monad
import Control.Applicative

instance (Arbitrary a, Integral a) => Arbitrary (Div a) where
    -- TODO positivity should be an invariant of the data itself
    arbitrary = Monad.liftM (Div . abs) arbitrary

instance (Arbitrary a) => Arbitrary (Bounds a) where
    arbitrary =
        frequency [ (1, return Zero),
                    (7, Monad.liftM Elt arbitrary),
                    (1, return One) ]

instance (Arbitrary a) => Arbitrary (FlatLattice a) where
    arbitrary =
        frequency [ (1, return FZero),
                    (7, Monad.liftM Flat arbitrary),
                    (1, return FOne) ]

instance Arbitrary a => Arbitrary (TotalOrder a) where
    arbitrary = Monad.liftM Tot arbitrary

instance Arbitrary a => Arbitrary (Envelope a) where
    -- TODO always starting with just one element in the envelope
    arbitrary = Monad.liftM (En . (:[])) arbitrary

prop_join_commutes :: (UnboundedJoinLattice a, Eq a) => a -> a -> Bool
prop_join_commutes x y = (x `join` y) == (y `join` x)

prop_join_assocs :: (UnboundedJoinLattice a, Eq a) => a -> a -> a -> Bool
prop_join_assocs x y z = ((x `join` y) `join` z) == (x `join` (y `join` z))

prop_join_idempotent :: (UnboundedJoinLattice a, Eq a) => a -> Bool
prop_join_idempotent x = (x `join` x) == x

prop_join_zero :: (JoinLattice a, Eq a) => a -> Bool
prop_join_zero x = (x `join` zero) == x && (zero `join` x) == x

prop_unbounded_lattice :: (UnboundedJoinLattice a, Eq a) => a -> a -> a -> Bool
prop_unbounded_lattice x y z =
    prop_join_commutes x y &&
    prop_join_assocs x y z &&
    prop_join_idempotent x

prop_lattice :: (JoinLattice a, Eq a) => a -> a -> a -> Bool
prop_lattice x y z =
    prop_unbounded_lattice x y z &&
    prop_join_zero x

prop_merge_preserves_content :: [Integer] -> [Integer] -> Bool
prop_merge_preserves_content xs ys =
    (sort $ unImp $ Imp xs `merge` Imp ys) == sort (xs ++ ys)

silly_stream =
    do x <- Imp [3..300]
       y <- Imp [x, 2*x]
       return y

-- TODO This is not a very good test of the statement that merge is
-- allowed to pull from whichever stream has stuff.
prop_merge_not_determined =
    (take 10 $ unImp silly_stream) /= [3,4,5,6,7,8,9,10,11,12] &&
    (take 10 $ unImp silly_stream) /= [3,6,4,8,5,10,6,12,7,14]

bottom :: a
bottom = unsafePerformIO hangIO

hangIO :: IO a
hangIO = do Monad.forever (threadDelay maxBound)
            return (error "_|_")

prop_merge_advances :: [Integer] -> Bool
prop_merge_advances xs =
    xs == take (length xs) (unImp $ Imp bottom `merge` Imp xs) &&
    xs == take (length xs) (unImp $ Imp xs `merge` Imp bottom)

sublist :: Eq a => [a] -> [a] -> Bool
sublist [] _ = True
sublist (x:xs) [] = False
sublist (x:xs) (y:ys) | x == y    = sublist xs ys
                      | otherwise = sublist (x:xs) ys

prop_sublist_intersperse :: Integer -> [Integer] -> Bool
prop_sublist_intersperse n ns = 
    sublist ns (intersperse n ns)

prop_drop_sublist :: [Integer] -> Bool
prop_drop_sublist xs =
    sublist (drop_eager xs) xs
-- TODO Teach the type system about positive integers?
sluggify_stream :: Int -> Int -> Int -> [a] -> [a]
sluggify_stream delay repeat 0 xs =
    unsafePerformIO 
    (do threadDelay delay
        return (sluggify_stream delay repeat repeat xs))
sluggify_stream _ _ _ [] = []
sluggify_stream delay repeat count (x:xs) =
    x:(sluggify_stream delay repeat (count - 1) xs)

prop_slug_ok :: Int -> [Integer] -> Bool
prop_slug_ok repeat xs = 
    (sluggify_stream 20 (abs repeat + 1) 0 xs) == xs

thin_stream :: Int -> [a] -> [a]
thin_stream _ [] = []
thin_stream repeat xs | length xs >= repeat = (xs!!(repeat-1)) : (thin_stream repeat $ drop repeat xs)
                      | otherwise = [last xs]

lengthed_list :: Arbitrary a => Int -> Gen [a]
lengthed_list 0 = return []
lengthed_list len = 
    do first <- arbitrary
       rest <- lengthed_list (len - 1)
       return (first:rest)

plausible_index :: [a] -> Gen Int
plausible_index lst = choose(0, (length lst) + 1)

-- This is too slow to run often, so I generate good input data for it
prop_drop_impatient :: Property
prop_drop_impatient =
    forAll (choose (0,15)) $ \len ->
        forAll (lengthed_list len ::(Gen [Integer])) $ \xs ->
               forAll (plausible_index xs) $ \repeat ->
                   let -- This slowness (0.1 seconds) suffices to get
                       -- the compiled code to obey the invariant, but
                       -- slows the unit tests down to a crawl.
                       a = (drop_eager $ drop_eager $ sluggify_stream 100000 (abs repeat + 1) 0 xs)
                       b = thin_stream (abs repeat + 1) xs
                   in a == b

prop_applicative :: [Integer -> Integer] -> [Integer] -> Bool
prop_applicative fs xs =
    merged `sublist` crossed where
        merged = unImp $ (Imp fs) <*> (Imp xs)
        crossed = concatMap (\f -> (map f xs)) fs

instance Show ((->) a b) where
    show f = "A function"

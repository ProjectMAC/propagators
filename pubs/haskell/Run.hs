import MergingTest
import Merging
import Test.QuickCheck.Batch

options = TestOptions
          { no_of_tests = 100,
            length_of_tests = 10,
            debug_tests = False }

slow_test_options = TestOptions
                    { no_of_tests = 15,
                      length_of_tests = 50,
                      debug_tests = False }

main = do
  runTests "lattices" options
       [ run (prop_unbounded_lattice :: Integer -> Integer -> Integer -> Bool)
       , run (prop_lattice :: (Div Integer) -> (Div Integer) -> (Div Integer) -> Bool)
       , run (prop_lattice :: (Div Integer, Div Integer) -> (Div Integer, Div Integer) -> (Div Integer, Div Integer) -> Bool)
       , run (prop_lattice :: (Bounds Integer) -> (Bounds Integer) -> (Bounds Integer) -> Bool)
       , run (prop_lattice :: (FlatLattice Integer) -> (FlatLattice Integer) -> (FlatLattice Integer) -> Bool)
       , run (prop_lattice :: (Envelope (TotalOrder Integer)) -> (Envelope (TotalOrder Integer)) -> (Envelope (TotalOrder Integer)) -> Bool)
       , run (prop_lattice :: (Envelope (FlatLattice Integer)) -> (Envelope (FlatLattice Integer)) -> (Envelope (FlatLattice Integer)) -> Bool)
       ]
  runTests "reorderable streams" options
       [ run prop_merge_preserves_content
       , run prop_merge_not_determined
       , run prop_merge_advances
       , run prop_sublist_intersperse
       , run prop_drop_sublist
       , run prop_applicative
       ]
  runTests "slow tests" slow_test_options
       [ run prop_slug_ok
       , run prop_drop_impatient
       ]

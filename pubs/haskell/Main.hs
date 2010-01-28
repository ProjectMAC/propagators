import Merging
import Control.Exception as Ctl


fibonacci 0 = 1
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)


mumble = do x <- Imp (filter (< 10) $ map fibonacci [1..])
            y <- Imp [1, x, x+1]
            return y

frotz = do x <- Imp [3..300]
           y <- Imp [x, 2*x]
           return y

interesting :: Exception -> Maybe Exception
-- interesting Deadlock = Just Deadlock
interesting NonTermination = Just NonTermination
interesting _ = Nothing

-- main = putStrLn "Hello world"
-- main = putStrLn $ show $ take 100 (unImp (merge (Imp (filter (> 100000) $ map fibonacci [1..])) (Imp [1000..])))
-- main = putStrLn $ show $ take 100 (unImp mumble)
-- main = putStrLn $ show $ unImp frotz
main = 
    Ctl.catchJust interesting (putStrLn $ show $ totalout)
           (\e -> putStrLn $ "Caught: " ++ show e)

-- main = do
--   result <- Ctl.tryJust interesting (putStrLn $ show $ totalout)
--   putStrLn $ show $ result

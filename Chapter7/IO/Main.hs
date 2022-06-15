module Hi where

import qualified Control.Monad
import System.Directory.Internal.Prelude (getArgs)
import Text.Printf (printf)
import Text.Read (readMaybe)

main :: IO ()
main =
  getArgs >>= print . sumArgs

sumArgs :: [String] -> Maybe Int
sumArgs strArgs =
  let intArgs = mapM readMaybe strArgs
   in sum <$> intArgs

lazyIODemo =
  let sayHello = putStrLn "hello"
      raiseAMathError = putStrLn "I'm an error" >> return (1 / 0)
   in sayHello
        >> raiseAMathError
        >> sayHello

makeAndReadFile :: Int -> IO String
makeAndReadFile fnumber =
  let fname = printf "./tmp/test/%d" fnumber
   in writeFile fname fname >> readFile fname

unsafe :: IO ()
unsafe =
  let files = mapM makeAndReadFile [1 .. 1000]
   in files >>= print

makeAndShow :: Int -> IO ()
makeAndShow n =
  makeAndReadFile n >>= putStrLn

safe :: IO ()
safe =
  foldl
    ( \io id ->
        io >> makeAndShow id
    )
    (return ())
    [1 .. 500]

safe' :: IO ()
safe' = mapM_ makeAndShow [1 .. 2000]

io1 :: String -> IO (IO String)
io1 n =
  return (return n)

run :: IO ()
run =
  io1 "512" >>= (>>= putStrLn)

io2 :: IO (IO a) -> IO a
io2 = Control.Monad.join

io3 :: a -> [IO a]
io3 a = [return a]

io4 :: [IO a] -> IO [a]
io4 = sequence
module Main where

import Data.ByteString (intercalate)
import System.Directory.Internal.Prelude (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> error "Require path, word, and replacement word"
    [path, word, replacement] -> do
      file <- readFile path
      print file
      let replaced = unwords (map (\w -> if w == word then replacement else w) splitWords)
          splitWords = words file
       in writeFile path replaced
    _ -> error "Too many arguments"

main' :: IO ()
main' = do
  args <- getArgs
  case args of
    [] -> error "Require path, word, and replacement word"
    -- Purposefully use bind operator
    [path, word, replacement] ->
      readFile path
        >>= ( \file ->
                print file
                  >> let replaced = unwords (map (\w -> if w == word then replacement else w) (words file))
                      in writeFile path replaced
            )
        >> return ()
    _ -> error "Too many arguments"
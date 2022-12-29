module Main where

import qualified HCat (runHCat)

main :: IO ()
main = do
  HCat.runHCat

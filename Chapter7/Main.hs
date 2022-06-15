module Main where

import System.Directory.Internal.Prelude (getArgs)
import Text.Read (readMaybe)

main =
  getArgs
    >>= ( \args ->
            let op = parseOp (head args)
                operands = drop 1 args
                total = eval op operands
             in print total
        )

data Op = Add | Sub | Mult

eval :: Op -> [String] -> Int
eval op operands =
  let ints = map read operands
   in case op of
        Add -> sum ints
        Sub -> foldl (-) (head ints) (drop 1 ints)
        Mult -> product ints

parseOp op
  | op == "+" = Add
  | op == "-" = Sub
  | op == "*" = Mult
  | otherwise = error "Invalid operation"

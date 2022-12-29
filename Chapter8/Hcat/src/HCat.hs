{-# LANGUAGE LambdaCase #-}

module HCat where

import qualified System.Environment as Env

runHCat :: IO ()
runHCat =
  handleArgs >>= \case
    Left errMsg -> putStrLn $ "Error: " <> errMsg
    Right filename -> readFile filename >>= putStrLn

handleArgs :: IO (Either String FilePath)
handleArgs =
  parseArgs <$> Env.getArgs
  where
    parseArgs argumentList =
      case argumentList of
        [fname] -> Right fname
        [] -> Left "no filename provided"
        _ -> Left "multile files not supported"
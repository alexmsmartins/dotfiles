#!/usr/bin/env runhaskell
-- stack --resolver lts-20.10 script

{-# LANGUAGE OverloadedStrings #-}

import Turtle

import Data.Typeable (typeOf)
import System.Environment (getArgs)
import System.Directory (doesDirectoryExist, doesFileExist, getDirectoryContents, listDirectory, renameFile)
import System.FilePath (takeBaseName, (</>))

-- Recursively find all README.md files in the given directory and rename them
renameReadmeFiles :: FilePath -> String -> IO ()
renameReadmeFiles dir originalFileName = do
  -- Get a list of all entries in the directory (excluding . and ..)
  subdirs <- listDirectory dir
  -- For each subdirectory, check if it contains a README.md file
  -- and rename it if found
  mapM_ (renameReadmeFileInDir dir) subdirs
    where
      renameReadmeFileInDir :: FilePath -> FilePath -> IO ()
      renameReadmeFileInDir parentDir subdir = do
        let subdirPath = parentDir </> subdir
            readmePath = subdirPath </> originalFileName
        -- Check if the subdirPath is a directory
        isDir <- doesDirectoryExist subdirPath
        -- Check if the readmePath exists
        hasReadme <- doesFileExist readmePath
        -- If the subdirPath is a directory and has a README.md file,
        -- rename the file to <subdir>.md
        when isDir $ do
          when hasReadme $ do 
            let newFilePath = subdirPath </> takeBaseName subdir <.> ".md"
            renameFile readmePath newFilePath
          -- for each subdirectory, enter it and recursively run the function again
          renameReadmeFiles subdirPath originalFileName

runMain :: String -> String -> IO ()
runMain [] _ = return ()
runMain _ [] = return ()
runMain dirPath originalFileName = do
  putStrLn $ dirPath ++ "/" ++ originalFileName
  renameReadmeFiles dirPath originalFileName

main :: IO ()
main = do
  args <- getArgs
  putStrLn $ "We got " ++ show (length args) ++ " parameters."
  case args of
    [path, originalFileName] -> do
      isDir <- doesDirectoryExist path
      when isDir $ do
        runMain path originalFileName
    _ -> do
      putStrLn "The number of parameters is wrong."


module Main where

import Foreign.C.String (CString, newCString)
import Bindings

main :: IO ()
main = do
  cStr <- newCString "Print me babe!"
  a <- newA
  b <- newB cStr
  hsFoo a
  hsFoo2 a 384857378
  hsFoo b
  hsBar b
  hsPrintIt b

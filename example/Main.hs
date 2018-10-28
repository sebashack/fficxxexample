module Main where

import Bindings

main :: IO ()
main = do
  a <- newA
  hsFoo a
  hsFoo2 a 384857378

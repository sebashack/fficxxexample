module Main where

import Bindings

main :: IO ()
main = do
  a <- newA
  b <- newB
  hsFoo a
  hsFoo2 a 384857378
  hsFoo b
  hsBar b

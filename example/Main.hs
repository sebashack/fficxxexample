module Main where

import Bindings

main :: IO ()
main = do
  a <- newA
  a_foo a

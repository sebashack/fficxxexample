module Main where

import Data.Array.CArray (CArray, toForeignPtr)
import Data.Array.IArray (listArray)
import Foreign.C.String (CString, newCString)
import Foreign.C.Types (CDouble)
import Foreign.ForeignPtr (withForeignPtr)

import Bindings

main :: IO ()
main = do
  cStr <- newCString "Print me babe!"
  let cArr :: CArray Int CDouble
      cArr = listArray (0, 10) [10,10,10,10,10,10,10,10,10,10]
      (arrSize, arrPtr) = toForeignPtr cArr
  a <- newA
  b <-  withForeignPtr arrPtr (\ptr -> newB cStr ptr (fromIntegral arrSize))
  hsFoo a
  hsFoo2 a 384857378
  hsFoo b
  hsBar b
  hsPrintIt b
  hsPrintArr b

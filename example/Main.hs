module Main where

import Control.Monad (forM_)
import Data.Array.CArray (CArray, toForeignPtr, unsafeForeignPtrToCArray)
import Data.Array.IArray (listArray, elems)
import Foreign.C.String (CString, newCString)
import Foreign.C.Types (CDouble)
import Foreign.ForeignPtr (withForeignPtr, newForeignPtr_)

import Bindings

main :: IO ()
main = do
  cStr <- newCString "Print me babe!"
  let cArr :: CArray Int CDouble
      cArr = listArray (0, 10) (replicate 11 10)
      (arrSize, arrPtr) = toForeignPtr cArr
  a <- newA
  b <-  withForeignPtr arrPtr (\ptr -> newB cStr ptr (fromIntegral arrSize))
  hsFoo a
  hsFoo2 a 384857378
  hsFoo b
  hsBar b
  hsPrintIt b
  hsPrintArr b
  arraySize <- hsGetSize b
  arrayPtr <- hsGetArr b
  arrayFrPtr <- newForeignPtr_ arrayPtr
  cArray <- unsafeForeignPtrToCArray arrayFrPtr (0, (fromIntegral (arraySize - 1) :: Integer))
  forM_ (elems cArray) print

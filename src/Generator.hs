module Generator
  ( genBindings
  ) where

import qualified Data.HashMap.Strict as HM (empty, singleton)
import FFICXX.Generate.Builder (simpleBuilder)
import FFICXX.Generate.Code.Primitive (cppclass, cppclass_)
import FFICXX.Generate.Type.Cabal
  ( AddCInc(..)
  , AddCSrc(..)
  , Cabal(..)
  , CabalName(..)
  )
import FFICXX.Generate.Type.Class
  ( CPPTypes(..)
  , CTypes(..)
  , Class(..)
  , Function(..)
  , IsConst(..)
  , ProtectedMethod(..)
  , Types(..)
  )
import FFICXX.Generate.Type.Config
  ( ModuleUnit(MU_Class, MU_TopLevel)
  , ModuleUnitImports(..)
  , ModuleUnitMap(..)
  )
import FFICXX.Generate.Type.PackageInterface (HeaderName(..))

configCabal :: Cabal
configCabal =
  Cabal
    { cabal_pkgname = CabalName "Bindings"
    , cabal_version = "0.0"
    , cabal_cheaderprefix = "Bindings"
    , cabal_moduleprefix = "Bindings"
    , cabal_additional_c_incs = []
    , cabal_additional_c_srcs = []
    , cabal_license = Just "BSD3"
    , cabal_licensefile = Just "LICENSE"
    , cabal_extraincludedirs = ["/home/sebastian/cppBindings/cpplib/include"]
    , cabal_extralibdirs = ["/home/sebastian/cppBindings/cpplib/lib"]
    , cabal_extrafiles = []
    , cabal_additional_pkgdeps = []
    , cabal_pkg_config_depends = []
    }

classAConstructor :: Function
classAConstructor = Constructor {func_args = [], func_alias = Nothing}

method1Binding :: Function
method1Binding =
  NonVirtual
    {func_ret = Void, func_name = "foo", func_args = [], func_alias = Nothing}

classA :: Class
classA =
  Class
    { class_cabal = configCabal
    , class_name = "A"
    , class_parents = []
    , class_protected = Protected []
    , class_alias = Nothing
    , class_funcs = [classAConstructor, method1Binding]
    , class_vars = []
    , class_tmpl_funcs = []
    }

classBConstructor :: Function
classBConstructor = Constructor {func_args = [], func_alias = Nothing}

method2Binding :: Function
method2Binding =
  Virtual
    { func_ret = cppclass_ $ classA
    , func_name = "method2"
    , func_args = [cppclass classA "x"]
    , func_alias = Nothing
    }

classB :: Class
classB =
  Class
    { class_cabal = configCabal
    , class_name = "B"
    , class_parents = [classA]
    , class_protected = Protected []
    , class_alias = Nothing
    , class_funcs = [classBConstructor, method2Binding]
    , class_vars = []
    , class_tmpl_funcs = []
    }

genBindings :: IO ()
genBindings = do
  simpleBuilder
    "Bindings"
    (ModuleUnitMap $
     HM.singleton (MU_Class "A") (ModuleUnitImports [] [HdrName "A.h"]))
    (configCabal, [classA], [], [])
    ["MyLib"]
    []

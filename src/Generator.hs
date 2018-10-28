module Generator
  ( genBindings
  ) where

import qualified Data.HashMap.Strict as HM (empty, singleton)
import System.Environment ( getEnv )
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

configCabal :: FilePath -> Cabal
configCabal soDir =
  Cabal
    { cabal_pkgname = CabalName "Bindings"
    , cabal_version = "0.0"
    , cabal_cheaderprefix = "Bindings"
    , cabal_moduleprefix = "Bindings"
    , cabal_additional_c_incs = []
    , cabal_additional_c_srcs = []
    , cabal_license = Just "BSD3"
    , cabal_licensefile = Just "LICENSE"
    , cabal_extraincludedirs = [soDir ++ "/include"]
    , cabal_extralibdirs = [soDir ++ "/lib"]
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

classA :: FilePath -> Class
classA  soDir =
  Class
    { class_cabal = configCabal soDir
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

method2Binding :: FilePath -> Function
method2Binding soDir =
  Virtual
    { func_ret = cppclass_ $ classA soDir
    , func_name = "method2"
    , func_args = [cppclass (classA soDir) "x"]
    , func_alias = Nothing
    }

classB :: FilePath -> Class
classB soDir =
  Class
    { class_cabal = configCabal soDir
    , class_name = "B"
    , class_parents = [classA soDir]
    , class_protected = Protected []
    , class_alias = Nothing
    , class_funcs = [classBConstructor, method2Binding soDir]
    , class_vars = []
    , class_tmpl_funcs = []
    }

genBindings :: IO ()
genBindings = do
  soDir <- getEnv "HS_SO_DIR"
  simpleBuilder
    "Bindings"
    (ModuleUnitMap $
     HM.singleton (MU_Class "A") (ModuleUnitImports [] [HdrName "A.h"]))
    (configCabal soDir, [classA soDir], [], [])
    ["MyLib"]
    []

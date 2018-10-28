module Generator
  ( genBindings
  ) where

import qualified Data.HashMap.Strict as HM (fromList)
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
import System.Environment (getEnv)

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
  Virtual
    { func_ret = Void
    , func_name = "foo"
    , func_args = []
    , func_alias = Just "hsFoo"
    }

method2Binding :: Function
method2Binding =
  Virtual
    { func_ret = Void
    , func_name = "foo2"
    , func_args = [(CT CTLong NoConst, "t")]
    , func_alias = Just "hsFoo2"
    }

classA :: FilePath -> Class
classA soDir =
  Class
    { class_cabal = configCabal soDir
    , class_name = "A"
    , class_parents = []
    , class_protected = Protected []
    , class_alias = Nothing
    , class_funcs = [classAConstructor, method1Binding, method2Binding]
    , class_vars = []
    , class_tmpl_funcs = []
    }

classBConstructor :: Function
classBConstructor = Constructor {func_args = [], func_alias = Nothing}

method3Binding :: Function
method3Binding =
  NonVirtual
    { func_ret = Void
    , func_name = "bar"
    , func_args = []
    , func_alias = Just "hsBar"
    }

classB :: FilePath -> Class
classB soDir =
  Class
    { class_cabal = configCabal soDir
    , class_name = "B"
    , class_parents = [classA soDir]
    , class_protected = Protected []
    , class_alias = Nothing
    , class_funcs = [classBConstructor, method3Binding]
    , class_vars = []
    , class_tmpl_funcs = []
    }

genBindings :: IO ()
genBindings = do
  soDir <- getEnv "HS_SO_DIR"
  simpleBuilder
    "Bindings"
    (ModuleUnitMap $
     HM.fromList
       [ (MU_Class "A", ModuleUnitImports [] [HdrName "A.h"])
       , (MU_Class "B", ModuleUnitImports [] [HdrName "B.h"])
       ])
    (configCabal soDir, [classA soDir, classB soDir], [], [])
    ["MyLib"]
    []

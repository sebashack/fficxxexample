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

method3Binding :: Function
method3Binding =
  NonVirtual
    { func_ret = Void
    , func_name = "bar"
    , func_args = []
    , func_alias = Just "hsBar"
    }

method4Binding :: Function
method4Binding =
  NonVirtual
    { func_ret = Void
    , func_name = "printIt"
    , func_args = []
    , func_alias = Just "hsPrintIt"
    }

method5Binding :: Function
method5Binding =
  NonVirtual
    { func_ret = Void
    , func_name = "printArr"
    , func_args = []
    , func_alias = Just "hsPrintArr"
    }

method6Binding :: Function
method6Binding =
  NonVirtual
    { func_ret = CT (CPointer CTDouble) NoConst
    , func_name = "getArr"
    , func_args = []
    , func_alias = Just "hsGetArr"
    }

method7Binding :: Function
method7Binding =
  NonVirtual
    { func_ret = CT CTUInt NoConst
    , func_name = "getSize"
    , func_args = []
    , func_alias = Just "hsGetSize"
    }

method8Binding :: Function
method8Binding =
  NonVirtual
    { func_ret = CT (CPointer CTDouble) NoConst
    , func_name = "getCreatedArr"
    , func_args = []
    , func_alias = Just "hsGetCreatedArr"
    }

method9Binding :: Function
method9Binding =
  NonVirtual
    { func_ret = CT CTUInt NoConst
    , func_name = "getCreatedSize"
    , func_args = []
    , func_alias = Just "hsGetCreatedSize"
    }

classBConstructor :: Function
classBConstructor =
  Constructor
    { func_args =
        [ (CT CTString Const, "str")
        , (CT (CPointer CTDouble) NoConst, "arr")
        , (CT CTUInt NoConst, "size")
        ]
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
    , class_funcs =
        [ classBConstructor
        , method3Binding
        , method4Binding
        , method5Binding
        , method6Binding
        , method7Binding
        , method8Binding
        , method9Binding
        ]
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

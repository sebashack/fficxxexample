#!/bin/bash
CURRENT_DIR="$( readlink -f "$( dirname "${BASH_SOURCE[0]}" )" )"
export LD_LIBRARY_PATH="${CURRENT_DIR}/dist/lib"
cd ..
stack install
cd exampleBindings
make -C cpplib
rm -rf Bindings working
generator
mkdir dist
stack install --local-bin-path "${CURRENT_DIR}/dist" --ghc-options=-optl-Wl,-rpath,'$ORIGIN/lib'

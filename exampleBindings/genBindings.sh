#!/bin/bash
CURRENT_DIR="$( readlink -f "$( dirname "${BASH_SOURCE[0]}" )" )"
export LD_LIBRARY_PATH="${CURRENT_DIR}/cpplib/lib"
cd ..
stack install
cd exampleBindings
make -C cpplib
rm -rf Bindings working
generator
stack build
stack exec example

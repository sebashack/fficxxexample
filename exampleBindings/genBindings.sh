export LD_LIBRARY_PATH="$( readlink -f "$( dirname "${BASH_SOURCE[0]}" )" )"/cpplib/lib
cd ..
stack install
cd exampleBindings
rm -rf Bindings working
generator
stack build
stack exec example

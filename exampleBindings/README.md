# exampleBindings
To generate the bindings and then run the example, run `./genBindings.sh` from this directory.
This will first install the project in the parent directory, and run it in this directory to generate
bindings to the code in `cpplib` using the `generate` executable. This generates
directories called `Bindings` and `working`.
Then it will run `make` in the `cpplib` directory.
Finally, it will build the project in this directory and run the example executable,
which is a Haskell program that uses the generated bindings.

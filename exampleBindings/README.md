# exampleBindings
To generate the bindings run `./genBindings.sh` from this directory.

It will run `make` in the `cpplib` directory, which will generate a `dist` directory with
the shared object file in `dist/lib` and the header files in `dist/include`.

Then the `generator` executable will be installed, and run in this directory to generate
bindings to the code from `cpplib`. Directories `Bindings` and `working` are produced.

Finally, the `example` executable is generated in `dist`, which you can run with `./example`.

`dist` is a self-contained distribution, which means that you can ship it wherever you want
because it contains the necessary shared object and header file dependencies for the executable
to work.

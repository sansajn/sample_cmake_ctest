This directory contains following

- `hello.cpp`: Catch 2 (v2) hello sample.

Catch2 related samples.

Install dependencies with 

```bash
sudo apt install catch2
```

> on debian based distributions e.g. kubuntu

command.

Build with

```bash
cmake -B build-sample_cmake_ctest -S sample_cmake_ctest
cmake --build build-sample_cmake_ctest -j16
```

commands from outside of `sample_cmake_ctest` project directory. Samples are build in a `build-sample_cmake_ctest` directory.

For a demonstration purpose unit tests for `hello` target are "exported" see

```cmake
enable_testing()

# ...

include(Catch)
catch_discover_tests(hello)
```

parts of build script. 

To run unit tests go to the build directory and run `ctest` command this way

```console
$ ctest --output-on-failure
Test project /home/hlavatovic/devel/sample/build-sample_cmake_ctest
    Start 1: vectors can be sized and resized
1/1 Test #1: vectors can be sized and resized ...   Passed    0.00 sec

100% tests passed, 0 tests failed out of 1

Total Test time (real) =   0.00 sec
```

> TODO: describe Jenkins setup ...


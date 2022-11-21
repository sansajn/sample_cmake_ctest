The repository contains CMake / CTest sample with docker and Jenkins integration.

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

> use `--verbose` for verbose build output in a `--build` command

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

To build inside docker image run

```bash
make -C docker/ build
```

> **note**: `build` target also handles docker image creation (but not update)

to build sample and

```bash
make -C docker/ test
```

to run unit tests.

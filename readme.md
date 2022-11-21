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

To build inside docker container run

```bash
make -C docker/ build
```

> **note**: `build` target also handles docker image creation (but not update)

command to build sample and

```bash
make -C docker/ test
```

command to run unit tests.

In a Jenkins create *Multibranch Pipeline* job and ensure *Mode* is set to `by Jenkinsfile` and *Script Path* to `Jenkinsfile` in a *Build Configuration* section.

> we expect docker installed and available for jenkins user on build machine

# About

The repository contains CMake / CTest sample for C++ project with docker and Jenkins integration.

**Contents**
- [Docker support](#docker-support)
    - [Copy build](#copy-build)
    - [Shared build](#shared-build)
- [Local build](#local-build)

## Docker support

Actualy there are at least two possible way how to approach docker support for C++ projects. I've called the first one approach *Copy build* and the second one *Shared build*.

### Copy build

Let's first start with *Copy build* approuch because it is the simplier one.

In *Copy build* approach we copy our source files inside the docker image during image build. Build and test steps are done with `docker exec` commands.

See `Dockerfile` and `Makefile` files to see how it can be done.

The advantages of the approach are

- easy to setup (simple `Dockerfile` and `Makefile`)
- can be used by Jenkins running itself from docker container with host shared `/var/run/docker.sock`

The possible disadvantage is that we need to build new docker image on every code change and that results to full project rebuild which can be costly for C++ projects.

To test *Copy build* approch run

```bash
make image
make build
make test
```

> or only `make test` as a one command

commands.

### Shared build

The second approach is to share source as local volume so build process results to binary files in a directory. 

The advantage of the approach is that we do not need full project rebuild on code change. 

The disadvantage is that this approach doesn't work in case Jenkins run from docker container. The reason for this is that source directory can't by mapped via local volume inside docker container with host shared `/var/run/docker.sock`.

See `Dockerfiles`, `Makefile` and `Jenkinsfile` in `shared_docker` directory to see how *Shared build* can be implemented.

Run

```bash
make -C shared_docker/ image
make -C shared_docker/ build
make -C shared_docker/ test
```

command to buidl and test sample project.


## Local build

The section describes local project build so a first step install dependencies with 

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

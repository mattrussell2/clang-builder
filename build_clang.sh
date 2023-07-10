#!/bin/bash
# build_clang.sh
# Matt Russell

# This script builds clang/clang++ on RHEL 7 which compiles / links code quickly. 
# Expectation is that gcc / llvm are installed. 

# TO BUILD GCC
# dowload necessary files
# configuration: $GCC_SRC_PATH/configure --prefix=$GCC_INSTALLPATH --enable-languages=c,c++ --disable-multilib
# building:      make bootstrap-lean -> will remove old bootstrap parts as needed -> ~7gb->1.3gb
# install:       make install 

set -exv

# location of gcc used to build clang
HOST_GCC=YOUR_GCC_INSTALL_PATH               # e.g. /h/mrussell/gcc
LLVM_SOURCE_PATH=YOUR_LLVM_INSTALL_PATH      # e.g. /h/mrussell/llvm-source/llvm
INSTALL_PREFIX=YOUR_INSTALL_LOCATION         # e.g. /h/mrussell/clang

CC=${HOST_GCC}/bin/gcc
CXX=${HOST_GCC}/bin/g++

# number of cores
CPUS=24

## build clang w/gcc installed in non-standard location
cmake -G Ninja \
      -DLLVM_ENABLE_PROJECTS=clang \
      -DCMAKE_C_COMPILER=${CC} \
      -DCMAKE_CXX_COMPILER=${CXX} \
      -DGCC_INSTALL_PREFIX=${HOST_GCC} \
      -DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${HOST_GCC}/lib64 -L${HOST_GCC}/lib64" \
      -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
      -DLLVM_LOCAL_RPATH="${HOST_GCC}/lib64" \
      -DLLVM_ENABLE_ASSERTIONS=ON \
      -DCMAKE_BUILD_TYPE="Release" \
      $LLVM_SOURCE_PATH

ninja -j ${CPUS}

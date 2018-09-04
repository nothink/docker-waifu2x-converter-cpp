#!/bin/sh

CMAKE_URL="https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz"

mkdir src
# get opencv files
wget -q -O - $CMAKE_URL | tar zxvf - -C src --strip-components 1
cd src
./configure
make
make install

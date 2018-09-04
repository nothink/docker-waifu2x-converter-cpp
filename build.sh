#!/bin/sh

set -eux && git clone https://github.com/DeadSix27/waifu2x-converter-cpp /opt/waifu2x-cpp/src

cmake ./src
make

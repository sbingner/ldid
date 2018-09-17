#!/bin/bash

set -e -x

make clean all CC="xcrun gcc" CXX="xcrun g++" CFLAGS="-arch i386 -arch x86_64 -mmacosx-version-min=10.4"

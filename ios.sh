#!/bin/bash

set -e -x

make clean all CC="xcrun -sdk iphoneos gcc" CXX="xcrun -sdk iphoneos g++" CFLAGS="-arch armv7 -arch arm64 -Xarch_arm64 -miphoneos-version-min=8.0 -Xarch_armv7 -miphoneos-version-min=3.0"

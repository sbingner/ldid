#!/bin/bash

set -e -x

if which xcrun &>/dev/null; then
	CC="xcrun gcc"
	CXX="xcrun g++"
	CFLAGS="-arch i386 -arch x86_64 -mmacosx-version-min=10.4"
else
	CC="gcc"
	CXX="g++"
	CFLAGS=""
fi

make clean all CC="${CC}" CXX="${CXX}" CFLAGS="${CFLAGS}"

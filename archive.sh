#!/bin/sh
VERSION="$(./version.sh)"
git archive --format tar --prefix "ldid-${VERSION}/" master | xz > "ldid-${VERSION}.tar.xz"

#!/bin/bash
./ios.sh
rm -rf _
make install DESTDIR="_"
mkdir -p _/DEBIAN
./control.sh _ >_/DEBIAN/control
mkdir -p debs
dpkg-deb -b _ debs/ldid_$(./version.sh)_iphoneos-arm.deb
echo debs/ldid_$(./version.sh)_iphoneos-arm.deb

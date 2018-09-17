#!/bin/bash
./ios.sh
rm -rf _
make install DESTDIR="_/usr"
make clean all
./ldid -Hsha1 -Hsha256 -Sents.xml _/usr/bin/ldid
mkdir -p _/DEBIAN
./control.sh _ >_/DEBIAN/control
mkdir -p debs
dpkg-deb -b _ debs/ldid_$(./version.sh)_iphoneos-arm.deb
echo debs/ldid_$(./version.sh)_iphoneos-arm.deb

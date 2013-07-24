#!/usr/bin/env bash

function check_result {
  if [ "0" -ne "$?" ]
  then
    (repo forall -c "git reset --hard") >/dev/null
    rm -f .repo/local_manifests/dyn-*.xml
    rm -f .repo/local_manifests/roomservice.xml
    echo $1
    exit 1
  fi
}

cd ..
if [ ! -d build ]
then
  git clone git://github.com/OpenELEC/OpenELEC.tv.git build
else
  git pull
fi
cd build

if [ "$PLATFORM" = "RPi" ]
then
  PROJECT=RPi ARCH=arm make
  check_result "build failed, aborting."
elif [ "$PLATFORM" = "i386" ]
then
  PROJECT=ION ARCH=i386 make release
  check_result "build failed, aborting."
elif [ "$PLATFORM" = "x86_64" ]
then
  PROJECT=ION ARCH=x86_64 make release
  check_result "build failed, aborting."
else
  echo no platform set, aborting.
fi

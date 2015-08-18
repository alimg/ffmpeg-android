#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd libvpx

make clean

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    HOST=armv7-android-gcc
    CROSS=armv7-android-gcc
    export CROSS
  ;;
  x86)
    HOST=x86-android-gcc
  ;;
esac

echo $CFLAGS

./configure \
   --target=$HOST\
  --sdk-path="$ANDROID_NDK" \
   --disable-runtime-cpu-detect \
   --disable-neon \
  --enable-pic \
  --enable-vp8 \
  --enable-vp9 \
  --enable-static \
  --disable-realtime-only \
  --disable-postproc \
  --disable-examples \
  --disable-docs \
  --disable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd

#!/bin/bash

export SEC_BUILD_CONF_VENDOR_BUILD_OS=13
export PLATFORM_VERSION=13
export ANDROID_MAJOR_VERSION=T
export ARCH=arm64

# Caminhos das toolchains
export CLANG_PATH=$PWD/toolchain/clang/host/linux-x86/clang-r349610-jopp
export GCC_PATH=$PWD/toolchain/gcc

# Exportações para usar LLVM corretamente
export CROSS_COMPILE=$GCC_PATH/bin/aarch64-linux-android-
export CLANG_TRIPLE=aarch64-linux-gnu-
export PATH="$CLANG_PATH/bin:$PATH"

export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip
export READELF=llvm-readelf
export HOSTAR=llvm-ar
export HOSTLD=ld.lld
export KCFLAGS="-Wno-gnu-variable-sized-type-not-at-end"

# Correção para dtc duplicado
export DTC_EXT=/usr/bin/dtc
touch scripts/dtc/dtc
chmod +x scripts/dtc/dtc

# Build
make O=out exynos9830-r8slte_defconfig
make O=out -j$(nproc) \
  CC=clang \
  CROSS_COMPILE=$CROSS_COMPILE \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  KCFLAGS="$KCFLAGS"

#!/bin/bash

export SEC_BUILD_CONF_VENDOR_BUILD_OS=13
export PLATFORM_VERSION=13
export ANDROID_MAJOR_VERSION=T
export ARCH=arm64

# Caminho da toolchain
export CLANG_PATH=$PWD/toolchain/clang/host/linux-x86/clang-r349610-jopp
export GCC_PATH=$PWD/toolchain/gcc

# Toolchain
export CROSS_COMPILE=$GCC_PATH/bin/aarch64-linux-android-
export CLANG_TRIPLE=aarch64-linux-gnu-

# Suprime erro de extensão do compilador (cgroup)
export KCFLAGS="-Wno-gnu-variable-sized-type-not-at-end"

# Adiciona Clang no PATH
export PATH="$CLANG_PATH/bin:$PATH"

make O=out exynos9830-r8slte_defconfig
make O=out -j$(nproc) \
  CC=clang \
  CROSS_COMPILE=$CROSS_COMPILE \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  KCFLAGS="$KCFLAGS"

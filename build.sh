# Set these variables to suit your needs
NDK_PATH=/Users/koroff/Android/ndk-bundle
BUILD_PLATFORM=darwin-x86_64
TOOLCHAIN_VERSION=4.9
ANDROID_VERSION=19

# 32-bit ARMv7 build
HOST=arm-linux-androideabi
SYSROOT=${NDK_PATH}/platforms/android-${ANDROID_VERSION}/arch-arm
ANDROID_CFLAGS="-march=armv7-a -mfloat-abi=softfp -fprefetch-loop-arrays \
 --sysroot=${SYSROOT}"

# 64-bit ARMv8 build
# HOST=aarch64-linux-android
# SYSROOT=${NDK_PATH}/platforms/android-${ANDROID_VERSION}/arch-arm64
# ANDROID_CFLAGS="--sysroot=${SYSROOT}"

TOOLCHAIN=${NDK_PATH}/toolchains/${HOST}-${TOOLCHAIN_VERSION}/prebuilt/${BUILD_PLATFORM}
ANDROID_INCLUDES="-I${SYSROOT}/usr/include -I${TOOLCHAIN}/include"
export CPP=${TOOLCHAIN}/bin/${HOST}-cpp
export AR=${TOOLCHAIN}/bin/${HOST}-ar
export AS=${TOOLCHAIN}/bin/${HOST}-as
export NM=${TOOLCHAIN}/bin/${HOST}-nm
export CC=${TOOLCHAIN}/bin/${HOST}-gcc
export LD=${TOOLCHAIN}/bin/${HOST}-ld
export RANLIB=${TOOLCHAIN}/bin/${HOST}-ranlib
export OBJDUMP=${TOOLCHAIN}/bin/${HOST}-objdump
export STRIP=${TOOLCHAIN}/bin/${HOST}-strip

sh configure --host=${HOST} --with-java \
  CFLAGS="${ANDROID_INCLUDES} ${ANDROID_CFLAGS} -O3 -fPIE" \
  CPPFLAGS="${ANDROID_INCLUDES} ${ANDROID_CFLAGS}" \
  LDFLAGS="${ANDROID_CFLAGS} -pie" --with-simd ${1+"$@"}
make

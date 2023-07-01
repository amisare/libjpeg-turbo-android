#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NDK_PATH=~/Library/Android/sdk/ndk/21.0.6113669
TOOLCHAIN_VERSION="4.9"
ANDROID_VERSION=21

function copy_header_files() {
    local src_dir="$1"  # 源目录
    local dst_dir="$2"  # 目标目录
    
    # 创建目标目录（如果不存在）
    mkdir -p "$dst_dir"
    
    # 遍历源目录中的所有 .h 文件
    for file in "$src_dir"/*.h; do
        # 提取文件名
        filename=$(basename "$file")
        # 拷贝文件到目标目录
        cp "$file" "$dst_dir/$filename"
    done
}

function copy_lib_files() {
    local src_dir="$1"  # 源目录
    local dst_dir="$2"  # 目标目录
    
    # 创建目标目录
    mkdir -p "$dst_dir"
    
    # 遍历源目录的二级子目录
    for dir in "$src_dir"/*; do
        # 检查是否是目录
        if [ -d "$dir" ]; then
            # 获取目录名
            dirname=$(basename "$dir")
            
            # 在目标目录中创建对应的目录
            mkdir -p "$dst_dir/$dirname"
            
            # 复制 .a 和 .so 文件到目标目录
            cp "$dir"/*.a "$dst_dir/$dirname"
            cp "$dir"/*.so "$dst_dir/$dirname"
        fi
    done
}

LIBJPEG_TURBO_DIR="$DIR/../../libjpeg-turbo"
LIBRARY_DIR="$DIR"
LIB_DIR="$LIBRARY_DIR/lib"
INCLUDE_DIR="$LIBRARY_DIR/include"

BUILD_LIBS_DIR="$DIR/libs"
BUILD_OBJ_DIR="$DIR/obj"

rm -rf "$LIB_DIR"
rm -rf "$INCLUDE_DIR"

# cmake
rm -rf build
mkdir build
cd build
cmake -G"Unix Makefiles" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_ARM_MODE=arm \
    -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
    -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
    -DCMAKE_ASM_FLAGS="--target=aarch64-linux-android${ANDROID_VERSION}" \
    -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
    $LIBJPEG_TURBO_DIR
cd ..
# 更新 binary 头文件
copy_header_files "build" "$INCLUDE_DIR"
copy_header_files "build/simd/arm" "$INCLUDE_DIR"
copy_header_files "$LIBJPEG_TURBO_DIR" "$INCLUDE_DIR"
sed -i '' 's/#define SIZEOF_SIZE_T  8/\/\/ #define SIZEOF_SIZE_T  8/' $LIBRARY_DIR/include/jconfigint.h
sed -i '' 's/#define BUILD  \".*\"/#define BUILD  __TIMESTAMP__/' $LIBRARY_DIR/include/jconfigint.h
# 更新 source 头文件
UPDATE_SOURCE_HEADERS=(
    "jconfig.h"
    "jconfigint.h"
    "jversion.h"
    "neon-compat.h"
)
for HEADER in "${UPDATE_SOURCE_HEADERS[@]}"; do
    cp -f "$INCLUDE_DIR/$HEADER" "$LIBRARY_DIR/../source/include/"
done
# 清空 cmake 文件夹
rm -rf build

# build
ndk-build NDK_PROJECT_PATH=$DIR APP_BUILD_SCRIPT=$DIR/../source/Android.mk clean
ndk-build NDK_PROJECT_PATH=$DIR APP_BUILD_SCRIPT=$DIR/../source/Android.mk

copy_lib_files "$BUILD_OBJ_DIR/local" "$LIB_DIR"

rm -rf "$BUILD_LIBS_DIR"
rm -rf "$BUILD_OBJ_DIR"

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

LIBJPEG_TURBO_DIR="$DIR/../../libjpeg-turbo"
LIBRARY_DIR="$DIR"
LIB_DIR="$LIBRARY_DIR/lib"
INCLUDE_DIR="$LIBRARY_DIR/include"

rm -rf "$LIB_DIR"
rm -rf "$INCLUDE_DIR"

APP_ABIS=(
    "x86"
    "x86_64"
    "armeabi-v7a"
    "arm64-v8a"
)

for ABI in "${APP_ABIS[@]}"; do
    
    # 零时构建目录
    rm -rf build
    mkdir build
    cd build
    
    if [ "$ABI" = "armeabi-v7a" ]; then
        
        cmake -G"Unix Makefiles" \
        -DANDROID_ABI=armeabi-v7a \
        -DANDROID_ARM_MODE=arm \
        -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
        -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
        -DCMAKE_ASM_FLAGS="--target=arm-linux-androideabi${ANDROID_VERSION}" \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        $LIBJPEG_TURBO_DIR \
        
        elif [ "$ABI" = "arm64-v8a" ]; then
        
        cmake -G"Unix Makefiles" \
        -DANDROID_ABI=arm64-v8a \
        -DANDROID_ARM_MODE=arm \
        -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
        -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
        -DCMAKE_ASM_FLAGS="--target=aarch64-linux-android${ANDROID_VERSION}" \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        $LIBJPEG_TURBO_DIR \
        
        elif [ "$ABI" = "x86" ]; then
        
        cmake -G"Unix Makefiles" \
        -DANDROID_ABI=x86 \
        -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
        -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        $LIBJPEG_TURBO_DIR \
        
        elif [ "$ABI" = "x86_64" ]; then
        
        cmake -G"Unix Makefiles" \
        -DANDROID_ABI=x86_64 \
        -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
        -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
        -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
        $LIBJPEG_TURBO_DIR \
        
    fi
    
    # 构建
    make -j4
    
    # 创建目录
    dst_dir="$LIB_DIR/$ABI"
    rm -rf "$dst_dir"
    mkdir -p "$dst_dir"
    
    # 文件数组
    src_files=(
        "libjpeg.a"
        "libjpeg.so"
        "libturbojpeg.a"
        "libturbojpeg.so"
    )
    
    # 遍历文件数组
    for file in "${src_files[@]}" ; do
        # 拷贝文件到目标目录
        cp "$file" "$dst_dir"
    done
    
    # 退出 build 目录
    cd ..
done

copy_header_files "build" "$INCLUDE_DIR"
copy_header_files "build/simd/arm" "$INCLUDE_DIR"
copy_header_files "$LIBJPEG_TURBO_DIR" "$INCLUDE_DIR"

rm -rf build

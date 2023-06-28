This repository provides a Android.mk build configuration for [libjpeg-turbo](http://libjpeg-turbo.virtualgl.org/).

## Usage

### Integration

Then add this repo as a submodule to your own project.

```
git submodule add https://github.com/amisare/libjpeg-turbo-android.git libjpeg-turbo-android
git submodule update --recurse-submodules
```

#### Source code integration

Add android/source/Android.mk to your project Android.mk

```
include <path to android/source>/Android.mk
```

#### Binary integration (only available libjpeg-turbo 3.0.x)

Add android/binary/Android.mk to your project Android.mk

```
include <path to android/binary>/Android.mk
```

## Updating

### Clone

This repo uses [Git Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to bring in dependent components.

To clone using HTTPS:
```
git clone https://github.com/amisare/libjpeg-turbo-android.git --recurse-submodules
```
Using SSH:
```
git clone git@github.com:amisare/libjpeg-turbo-android.git --recurse-submodules
```

If you have downloaded the repo without using the `--recurse-submodules` argument, you need to run:
```
git submodule update --init --recursive
```

### Modify

The [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git) is a submodule of [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git). In [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git), there are version branches corresponding to [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git).

For example, to upgrade the [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git) version to 1.5.x, first switch the [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git) repository to the corresponding branch, which is 1.5.x.

### Build and check
#### Source code

Testing build

```
cd android/source
ndk-build NDK_PROJECT_PATH=$(pwd) APP_BUILD_SCRIPT=$(pwd)/Android.mk
```

#### Binary

**It successfully run only on macOS, without attempting on other systems.**

```
cd android/binary
```

Edit **build.sh** according your configuration.
```
NDK_PATH=~/Library/Android/sdk/ndk/21.0.6113669
TOOLCHAIN_VERSION="4.9"
ANDROID_VERSION=21
```

Run build script
```
./build.sh
```

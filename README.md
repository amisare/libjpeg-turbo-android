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
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# begin libusb
LIBJPEG_TURBO_PATH := $(LOCAL_PATH)/<path to>/libjpeg-turbo-android/android/source/Android.mk
# LIBJPEG_TURBO_LIB_TYPE := STATIC
# or
# LIBJPEG_TURBO_LIB_TYPE := SHARED
include $(LIBJPEG_TURBO_PATH)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LIBJPEG_TURBO_LOCAL_C_INCLUDES)
LOCAL_EXPORT_C_INCLUDES += $(LIBJPEG_TURBO_LOCAL_EXPORT_C_INCLUDES)
LOCAL_STATIC_LIBRARIES += $(LIBJPEG_TURBO_LOCAL_STATIC_LIBRARIES)
LOCAL_SHARED_LIBRARIES += $(LIBJPEG_TURBO_LOCAL_SHARED_LIBRARIES)
# end libusb

# your config
```

#### Binary integration (only available libjpeg-turbo 3.0.x)

Add android/binary/Android.mk to your project Android.mk

```
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# begin libusb
LIBJPEG_TURBO_PATH := $(LOCAL_PATH)/<path to>/libjpeg-turbo-android/android/binary/Android.mk
# LIBJPEG_TURBO_LIB_TYPE := STATIC
# or
# LIBJPEG_TURBO_LIB_TYPE := SHARED
include $(LIBJPEG_TURBO_PATH)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LIBJPEG_TURBO_LOCAL_C_INCLUDES)
LOCAL_EXPORT_C_INCLUDES += $(LIBJPEG_TURBO_LOCAL_EXPORT_C_INCLUDES)
LOCAL_STATIC_LIBRARIES += $(LIBJPEG_TURBO_LOCAL_STATIC_LIBRARIES)
LOCAL_SHARED_LIBRARIES += $(LIBJPEG_TURBO_LOCAL_SHARED_LIBRARIES)
# end libusb

# your config
```

## Updating

### Clone

This repo uses [Git Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to bring in dependent components.

```
git clone https://github.com/amisare/libjpeg-turbo-android.git --recurse-submodules
```

If you have downloaded the repo without using the `--recurse-submodules` argument, you need to run:
```
git submodule update --init --recursive
```

### Modify

The [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git) is a submodule of [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git). In [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git), there are version branches corresponding to [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git).

For example, to upgrade the [libjpeg-turbo](https://github.com/libjpeg-turbo/libjpeg-turbo.git) version to 2.1.5, first switch the [libjpeg-turbo-android](https://github.com/amisare/libjpeg-turbo-android.git) repository to the corresponding tag, which is 2.1.5.x.

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

Run build script
```
./build.sh
```

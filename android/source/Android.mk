#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# LIBJPEG_TURBO_LIB_TYPE := STATIC
ifeq ($(LIBJPEG_TURBO_LIB_TYPE),)
    LIBJPEG_TURBO_LIB_TYPE := SHARED
endif

include $(LOCAL_PATH)/jpeg.mk
include $(LOCAL_PATH)/turbojpeg.mk
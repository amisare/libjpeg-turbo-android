#
# Created by GuHaijun on 2023/6/25.
#

USER_LOCAL_PATH:=$(LOCAL_PATH)

LOCAL_PATH := $(call my-dir)

ifeq ($(LIBJPEG_TURBO_LIB_TYPE),)
    LIBJPEG_TURBO_LIB_TYPE := SHARED
endif

include $(LOCAL_PATH)/jpeg.mk
include $(LOCAL_PATH)/turbojpeg.mk

LOCAL_PATH:=$(USER_LOCAL_PATH)
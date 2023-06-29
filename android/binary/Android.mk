#
# Created by GuHaijun on 2023/6/26.
#

LOCAL_PATH := $(call my-dir)

LIBJPEG_TURBO_C_INCLUDES_DIR := $(LOCAL_PATH)/include
LIBJPEG_TURBO_LIBS_DIR := lib/$(TARGET_ARCH_ABI)

include $(CLEAR_VARS)
LOCAL_MODULE := jpeg_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libjpeg_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := jpeg
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libjpeg.so
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_SHARED_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := turbojpeg_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libturbojpeg_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := turbojpeg
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libturbojpeg.so
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_SHARED_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := jpeg12_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libjpeg12_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := jpeg16_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libjpeg16_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := turbojpeg12_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libturbojpeg12_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := turbojpeg16_static
LOCAL_EXPORT_C_INCLUDES := $(LIBJPEG_TURBO_C_INCLUDES_DIR)
LOCAL_SRC_FILES := $(LIBJPEG_TURBO_LIBS_DIR)/libturbojpeg16_static.a
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(PREBUILT_STATIC_LIBRARY)
endif
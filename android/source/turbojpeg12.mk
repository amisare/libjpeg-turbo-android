#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(LOCAL_PATH)/source_paths.mk

SOURCE_PATH := $(JPEG_TURBO_SRC_PATH)

# c file
LOCAL_C_SRC_FILES := rdppm.c wrppm.c
LOCAL_SRC_FILES += $(addprefix $(SOURCE_PATH)/, $(LOCAL_C_SRC_FILES))

LOCAL_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_C_INCLUDES))
LOCAL_EXPORT_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_EXPORT_C_INCLUDES))

LOCAL_CFLAGS += \
	-DBITS_IN_JSAMPLE=12 \
	-DPPM_SUPPORTED \

# lib static
LOCAL_MODULE := turbojpeg12_static
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif

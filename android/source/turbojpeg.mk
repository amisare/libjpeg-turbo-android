#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(LOCAL_PATH)/source_paths.mk
include $(LOCAL_PATH)/source_files.mk

SOURCE_PATH := $(JPEG_TURBO_SRC_PATH)

LOCAL_ARM_NEON = $(JPEG_TURBO_LOCAL_ARM_NEON)
LOCAL_CFLAGS += $(JPEG_TURBO_LOCAL_CFLAGS)
LOCAL_ASMFLAGS += $(JPEG_TURBO_LOCAL_ASMFLAGS)

LOCAL_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(JPEG_TURBO_C_SRC_FILES)

# c file
LOCAL_C_SRC_FILES := turbojpeg.c transupp.c jdatadst-tj.c jdatasrc-tj.c rdbmp.c rdppm.c \
      wrbmp.c wrppm.c

LOCAL_SRC_FILES += $(addprefix $(SOURCE_PATH)/, $(LOCAL_C_SRC_FILES))

# include
LOCAL_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_C_INCLUDES))
LOCAL_EXPORT_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_EXPORT_C_INCLUDES))

LOCAL_CFLAGS += \
	-DBMP_SUPPORTED=1 \
	-DPPM_SUPPORTED=1 \

# depanencies
LOCAL_STATIC_LIBRARIES += jpeg12_static
LOCAL_STATIC_LIBRARIES += jpeg16_static
LOCAL_STATIC_LIBRARIES += turbojpeg12_static
LOCAL_STATIC_LIBRARIES += turbojpeg16_static

# lib static
LOCAL_MODULE := turbojpeg_static
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif

# lib share
include $(CLEAR_VARS)
LOCAL_EXPORT_LDLIBS += -llog

LOCAL_WHOLE_STATIC_LIBRARIES = turbojpeg_static
LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

LOCAL_MODULE := turbojpeg
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_SHARED_LIBRARY)
endif

include $(LOCAL_PATH)/jpeg12.mk
include $(LOCAL_PATH)/jpeg16.mk
include $(LOCAL_PATH)/turbojpeg12.mk
include $(LOCAL_PATH)/turbojpeg16.mk

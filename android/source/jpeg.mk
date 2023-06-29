#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(LOCAL_PATH)/source_paths.mk
include $(LOCAL_PATH)/source_files.mk

SOURCE_PATH = $(JPEG_TURBO_SRC_PATH)

LOCAL_ARM_NEON = $(JPEG_TURBO_LOCAL_ARM_NEON)
LOCAL_CFLAGS += $(JPEG_TURBO_LOCAL_CFLAGS)
LOCAL_ASMFLAGS += $(JPEG_TURBO_LOCAL_ASMFLAGS)

LOCAL_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(JPEG_TURBO_C_SRC_FILES)

# include
LOCAL_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_C_INCLUDES))
LOCAL_EXPORT_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_EXPORT_C_INCLUDES))

# depanencies
LOCAL_STATIC_LIBRARIES += jpeg12_static
LOCAL_STATIC_LIBRARIES += jpeg16_static

# lib static
LOCAL_MODULE := jpeg_static
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif

# lib share
ifeq ($(LIBJPEG_TURBO_LIB_TYPE), SHARED)
    include $(CLEAR_VARS)
    LOCAL_EXPORT_LDLIBS += -llog

    LOCAL_WHOLE_STATIC_LIBRARIES = jpeg_static
    LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

    LOCAL_MODULE := jpeg
    ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
        include $(BUILD_SHARED_LIBRARY)
    endif
endif

include $(LOCAL_PATH)/jpeg12.mk
include $(LOCAL_PATH)/jpeg16.mk

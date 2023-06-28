#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(LOCAL_PATH)/source_paths.mk

SOURCE_PATH := $(JPEG_TURBO_SRC_PATH)

# c file
LOCAL_C_SRC_FILES := jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jcdiffct.c \
  jclossls.c jcmainct.c jcprepct.c jcsample.c jdapistd.c jdcoefct.c jdcolor.c \
  jddctmgr.c jddiffct.c jdlossls.c jdmainct.c jdmerge.c jdpostct.c jdsample.c \
  jfdctfst.c jfdctint.c jidctflt.c jidctfst.c jidctint.c jidctred.c jquant1.c \
  jquant2.c jutils.c \

LOCAL_SRC_FILES += $(addprefix $(SOURCE_PATH)/, $(LOCAL_C_SRC_FILES))

LOCAL_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_C_INCLUDES))
LOCAL_EXPORT_C_INCLUDES += $(addprefix $(LOCAL_PATH)/, $(JPEG_TURBO_EXPORT_C_INCLUDES))

LOCAL_CFLAGS += \
	-DBITS_IN_JSAMPLE=12 \

# lib static
LOCAL_MODULE := jpeg12
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif

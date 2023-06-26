#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

SOURCE_PATH := libjpeg-turbo
SOURCE_SIMD_PATH := $(SOURCE_PATH)/simd

ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard x86),)
LOCAL_ARM_NEON := true
LOCAL_CFLAGS += -D__ARM_HAVE_NEON
endif

LOCAL_ASMFLAGS += -DELF

# asm file
ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_SIMD_SRC_FILES := jfdctflt-sse-64 jccolor-sse2-64 jcgray-sse2-64 \
    jchuff-sse2-64 jcsample-sse2-64 jdcolor-sse2-64 jdmerge-sse2-64 \
    jdsample-sse2-64 jfdctfst-sse2-64 jfdctint-sse2-64 jidctflt-sse2-64 \
    jidctfst-sse2-64 jidctint-sse2-64 jidctred-sse2-64 jquantf-sse2-64 \
    jquanti-sse2-64 \

LOCAL_SIMD_SRC_FILES := $(addprefix $(SOURCE_SIMD_PATH)/, $(LOCAL_SIMD_SRC_FILES))
LOCAL_SIMD_SRC_FILES := $(addsuffix .asm, $(LOCAL_SIMD_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(SOURCE_SIMD_PATH)/jsimd_x86_64.c

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SIMD_SRC_FILES := jsimdcpu jfdctflt-3dn jidctflt-3dn jquant-3dn jccolor-mmx \
    jcgray-mmx jcsample-mmx jdcolor-mmx jdmerge-mmx jdsample-mmx jfdctfst-mmx \
    jfdctint-mmx jidctfst-mmx jidctint-mmx jidctred-mmx jquant-mmx jfdctflt-sse \
    jidctflt-sse jquant-sse jccolor-sse2 jcgray-sse2 jchuff-sse2 jcsample-sse2 \
    jdcolor-sse2 jdmerge-sse2 jdsample-sse2 jfdctfst-sse2 jfdctint-sse2 \
    jidctflt-sse2 jidctfst-sse2 jidctint-sse2 jidctred-sse2 jquantf-sse2 \
    jquanti-sse2 \

LOCAL_SIMD_SRC_FILES := $(addprefix $(SOURCE_SIMD_PATH)/, $(LOCAL_SIMD_SRC_FILES))
LOCAL_SIMD_SRC_FILES := $(addsuffix .asm, $(LOCAL_SIMD_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(SOURCE_SIMD_PATH)/jsimd_i386.c

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

LOCAL_ASMFLAGS += -DPIC

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard armeabi),)
LOCAL_SRC_FILES += \
	$(SOURCE_SIMD_PATH)/jsimd_arm.c \
	$(SOURCE_SIMD_PATH)/jsimd_arm_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
	$(SOURCE_SIMD_PATH)/jsimd_arm64.c \
	$(SOURCE_SIMD_PATH)/jsimd_arm64_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

endif

# c file
LOCAL_C_SRC_FILES := jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c \
  jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c jcphuff.c \
  jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c jdatadst.c jdatasrc.c \
  jdcoefct.c jdcolor.c jddctmgr.c jdhuff.c jdinput.c jdmainct.c jdmarker.c \
  jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c jdtrans.c jerror.c \
  jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c jidctint.c jidctred.c \
  jquant1.c jquant2.c jutils.c jmemmgr.c jmemnobs.c \

LOCAL_C_SRC_FILES += jaricom.c
LOCAL_C_SRC_FILES += jcarith.c
LOCAL_C_SRC_FILES += jdarith.c
LOCAL_C_SRC_FILES += turbojpeg.c transupp.c jdatadst-tj.c jdatasrc-tj.c

LOCAL_C_SRC_FILES := $(addprefix $(SOURCE_PATH)/, $(LOCAL_C_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_C_SRC_FILES)


 LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/include \
 	$(LOCAL_PATH)/$(SOURCE_PATH) \
    $(LOCAL_PATH)/$(SOURCE_PATH)/win \
    $(LOCAL_PATH)/$(SOURCE_SIMD_PATH) \
    $(LOCAL_PATH)/$(SOURCE_SIMD_PATH)/nasm \


LOCAL_EXPORT_C_INCLUDES := \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/$(SOURCE_PATH) \


LOCAL_CFLAGS += \
	-DBMP_SUPPORTED=1 \
	-DPPM_SUPPORTED=1 \

# lib static
LOCAL_MODULE := libjpeg-turbo-1.5_static
include $(BUILD_STATIC_LIBRARY)

# lib share
include $(CLEAR_VARS)
LOCAL_EXPORT_LDLIBS += -llog

LOCAL_WHOLE_STATIC_LIBRARIES = libjpeg-turbo-1.5_static
LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

LOCAL_MODULE := libjpeg-turbo-1.5
include $(BUILD_SHARED_LIBRARY)

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
LOCAL_SIMD_SRC_FILES := x86_64/jsimdcpu.asm x86_64/jfdctflt-sse.asm \
    x86_64/jccolor-sse2.asm x86_64/jcgray-sse2.asm x86_64/jchuff-sse2.asm \
    x86_64/jcphuff-sse2.asm x86_64/jcsample-sse2.asm x86_64/jdcolor-sse2.asm \
    x86_64/jdmerge-sse2.asm x86_64/jdsample-sse2.asm x86_64/jfdctfst-sse2.asm \
    x86_64/jfdctint-sse2.asm x86_64/jidctflt-sse2.asm x86_64/jidctfst-sse2.asm \
    x86_64/jidctint-sse2.asm x86_64/jidctred-sse2.asm x86_64/jquantf-sse2.asm \
    x86_64/jquanti-sse2.asm \
    x86_64/jccolor-avx2.asm x86_64/jcgray-avx2.asm x86_64/jcsample-avx2.asm \
    x86_64/jdcolor-avx2.asm x86_64/jdmerge-avx2.asm x86_64/jdsample-avx2.asm \
    x86_64/jfdctint-avx2.asm x86_64/jidctint-avx2.asm x86_64/jquanti-avx2.asm \

LOCAL_SIMD_SRC_FILES := $(addprefix $(SOURCE_SIMD_PATH)/, $(LOCAL_SIMD_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(SOURCE_SIMD_PATH)/x86_64/jsimd.c

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SIMD_SRC_FILES := i386/jsimdcpu.asm i386/jfdctflt-3dn.asm \
    i386/jidctflt-3dn.asm i386/jquant-3dn.asm \
    i386/jccolor-mmx.asm i386/jcgray-mmx.asm i386/jcsample-mmx.asm \
    i386/jdcolor-mmx.asm i386/jdmerge-mmx.asm i386/jdsample-mmx.asm \
    i386/jfdctfst-mmx.asm i386/jfdctint-mmx.asm i386/jidctfst-mmx.asm \
    i386/jidctint-mmx.asm i386/jidctred-mmx.asm i386/jquant-mmx.asm \
    i386/jfdctflt-sse.asm i386/jidctflt-sse.asm i386/jquant-sse.asm \
    i386/jccolor-sse2.asm i386/jcgray-sse2.asm i386/jchuff-sse2.asm \
    i386/jcphuff-sse2.asm i386/jcsample-sse2.asm i386/jdcolor-sse2.asm \
    i386/jdmerge-sse2.asm i386/jdsample-sse2.asm i386/jfdctfst-sse2.asm \
    i386/jfdctint-sse2.asm i386/jidctflt-sse2.asm i386/jidctfst-sse2.asm \
    i386/jidctint-sse2.asm i386/jidctred-sse2.asm i386/jquantf-sse2.asm \
    i386/jquanti-sse2.asm \
    i386/jccolor-avx2.asm i386/jcgray-avx2.asm i386/jcsample-avx2.asm \
    i386/jdcolor-avx2.asm i386/jdmerge-avx2.asm i386/jdsample-avx2.asm \
    i386/jfdctint-avx2.asm i386/jidctint-avx2.asm i386/jquanti-avx2.asm \

LOCAL_SIMD_SRC_FILES := $(addprefix $(SOURCE_SIMD_PATH)/, $(LOCAL_SIMD_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_SIMD_SRC_FILES)
LOCAL_SRC_FILES += $(SOURCE_SIMD_PATH)/i386/jsimd.c

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

LOCAL_ASMFLAGS += -DPIC

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard armeabi),)
LOCAL_SRC_FILES += \
	$(SOURCE_SIMD_PATH)/arm/jsimd.c \
	$(SOURCE_SIMD_PATH)/arm/jsimd_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
	$(SOURCE_SIMD_PATH)/arm64/jsimd.c \
	$(SOURCE_SIMD_PATH)/arm64/jsimd_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

endif

# c file
LOCAL_C_SRC_FILES := jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c \
  jcicc.c jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c \
  jcphuff.c jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c jdatadst.c \
  jdatasrc.c jdcoefct.c jdcolor.c jddctmgr.c jdhuff.c jdicc.c jdinput.c \
  jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c \
  jdtrans.c jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c \
  jidctint.c jidctred.c jquant1.c jquant2.c jutils.c jmemmgr.c jmemnobs.c \

LOCAL_C_SRC_FILES += jaricom.c
LOCAL_C_SRC_FILES += jcarith.c
LOCAL_C_SRC_FILES += jdarith.c
LOCAL_C_SRC_FILES += turbojpeg.c transupp.c jdatadst-tj.c jdatasrc-tj.c rdbmp.c rdppm.c \
      wrbmp.c wrppm.c

LOCAL_C_SRC_FILES := $(addprefix $(SOURCE_PATH)/, $(LOCAL_C_SRC_FILES))

LOCAL_SRC_FILES += $(LOCAL_C_SRC_FILES)


LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/$(SOURCE_PATH) \
    $(LOCAL_PATH)/$(SOURCE_SIMD_PATH) \
    $(LOCAL_PATH)/$(SOURCE_SIMD_PATH)/nasm \

LOCAL_EXPORT_C_INCLUDES := \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/$(SOURCE_PATH) \


LOCAL_CFLAGS += \
	-DBMP_SUPPORTED=1 \
	-DPPM_SUPPORTED=1 \

# lib static
LOCAL_MODULE := libjpeg-turbo-2.0_static
include $(BUILD_STATIC_LIBRARY)

# lib share
include $(CLEAR_VARS)
LOCAL_EXPORT_LDLIBS += -llog

LOCAL_WHOLE_STATIC_LIBRARIES = libjpeg-turbo-2.0_static
LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

LOCAL_MODULE := libjpeg-turbo-2.0
include $(BUILD_SHARED_LIBRARY)

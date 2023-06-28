#
# Created by GuHaijun on 2023/6/25.
#

LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/source_paths.mk

JPEG_TURBO_LOCAL_ARM_NEON :=
JPEG_TURBO_LOCAL_CFLAGS := 
JPEG_TURBO_LOCAL_ASMFLAGS := 

JPEG_TURBO_SIMD_SRC_FILES :=
JPEG_TURBO_C_SRC_FILES :=

ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard x86 x86_64),)
JPEG_TURBO_LOCAL_ARM_NEON += true
JPEG_TURBO_LOCAL_CFLAGS += -D__ARM_HAVE_NEON
endif

JPEG_TURBO_LOCAL_ASMFLAGS += -DELF

# asm file
ifeq ($(TARGET_ARCH_ABI),x86_64)
JPEG_TURBO_SIMD_SRC_FILE_PATH := x86_64/jsimdcpu.asm x86_64/jfdctflt-sse.asm \
    x86_64/jccolor-sse2.asm x86_64/jcgray-sse2.asm x86_64/jchuff-sse2.asm \
    x86_64/jcphuff-sse2.asm x86_64/jcsample-sse2.asm x86_64/jdcolor-sse2.asm \
    x86_64/jdmerge-sse2.asm x86_64/jdsample-sse2.asm x86_64/jfdctfst-sse2.asm \
    x86_64/jfdctint-sse2.asm x86_64/jidctflt-sse2.asm x86_64/jidctfst-sse2.asm \
    x86_64/jidctint-sse2.asm x86_64/jidctred-sse2.asm x86_64/jquantf-sse2.asm \
    x86_64/jquanti-sse2.asm \
    x86_64/jccolor-avx2.asm x86_64/jcgray-avx2.asm x86_64/jcsample-avx2.asm \
    x86_64/jdcolor-avx2.asm x86_64/jdmerge-avx2.asm x86_64/jdsample-avx2.asm \
    x86_64/jfdctint-avx2.asm x86_64/jidctint-avx2.asm x86_64/jquanti-avx2.asm \

JPEG_TURBO_SIMD_SRC_FILE_PATH := $(addprefix $(JPEG_TURBO_SIMD_SRC_PATH)/, $(JPEG_TURBO_SIMD_SRC_FILE_PATH))

JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILE_PATH)
JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_PATH)/x86_64/jsimd.c

JPEG_TURBO_LOCAL_CFLAGS += -DSIZEOF_SIZE_T=8
JPEG_TURBO_LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
JPEG_TURBO_SIMD_SRC_FILE_PATH := i386/jsimdcpu.asm i386/jfdctflt-3dn.asm \
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

JPEG_TURBO_SIMD_SRC_FILE_PATH := $(addprefix $(JPEG_TURBO_SIMD_SRC_PATH)/, $(JPEG_TURBO_SIMD_SRC_FILE_PATH))

JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILE_PATH)
JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_PATH)/i386/jsimd.c

JPEG_TURBO_LOCAL_CFLAGS += -DSIZEOF_SIZE_T=4
JPEG_TURBO_LOCAL_ASMFLAGS += -DPIC

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard armeabi arm64-v8a),)

JPEG_TURBO_SIMD_SRC_FILE_PATH := arm/jcgray-neon.c arm/jcphuff-neon.c arm/jcsample-neon.c \
    arm/jdmerge-neon.c arm/jdsample-neon.c arm/jfdctfst-neon.c \
    arm/jidctred-neon.c arm/jquanti-neon.c \

JPEG_TURBO_SIMD_SRC_FILE_PATH := $(addprefix $(JPEG_TURBO_SIMD_SRC_PATH)/, $(JPEG_TURBO_SIMD_SRC_FILE_PATH))
JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILE_PATH)

    ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard armeabi),)

    JPEG_TURBO_SIMD_SRC_FILE_PATH := arm/aarch32/jsimd.c \
        arm/aarch32/jsimd_neon.S \
        arm/aarch32/jchuff-neon.c \
        arm/jdcolor-neon.c \
        arm/jfdctint-neon.c \

    JPEG_TURBO_SIMD_SRC_FILE_PATH := $(addprefix $(JPEG_TURBO_SIMD_SRC_PATH)/, $(JPEG_TURBO_SIMD_SRC_FILE_PATH))
    JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILE_PATH)

    JPEG_TURBO_LOCAL_CFLAGS += \
        -DSIZEOF_SIZE_T=4 \
        -mfpu=neon \

    else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)

    JPEG_TURBO_SIMD_SRC_FILE_PATH := arm/aarch64/jsimd.c \
        arm/aarch64/jsimd_neon.S \
        arm/jidctfst-neon.c \

    JPEG_TURBO_SIMD_SRC_FILE_PATH := $(addprefix $(JPEG_TURBO_SIMD_SRC_PATH)/, $(JPEG_TURBO_SIMD_SRC_FILE_PATH))
    JPEG_TURBO_SIMD_SRC_FILES += $(JPEG_TURBO_SIMD_SRC_FILE_PATH)

    JPEG_TURBO_LOCAL_CFLAGS += \
        -DSIZEOF_SIZE_T=8 \

    endif

endif

# c file
JPEG_TURBO_C_SRC_FILE_PATH := jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c \
  jcdiffct.c jchuff.c jcicc.c jcinit.c jclhuff.c jclossls.c jcmainct.c \
  jcmarker.c jcmaster.c jcomapi.c jcparam.c jcphuff.c jcprepct.c jcsample.c \
  jctrans.c jdapimin.c jdapistd.c jdatadst.c jdatasrc.c jdcoefct.c jdcolor.c \
  jddctmgr.c jddiffct.c jdhuff.c jdicc.c jdinput.c jdlhuff.c jdlossls.c \
  jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c \
  jdtrans.c jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c \
  jidctint.c jidctred.c jquant1.c jquant2.c jutils.c jmemmgr.c jmemnobs.c \

JPEG_TURBO_C_SRC_FILE_PATH += jaricom.c
JPEG_TURBO_C_SRC_FILE_PATH += jcarith.c
JPEG_TURBO_C_SRC_FILE_PATH += jdarith.c

JPEG_TURBO_C_SRC_FILES := $(addprefix $(JPEG_TURBO_SRC_PATH)/, $(JPEG_TURBO_C_SRC_FILE_PATH))

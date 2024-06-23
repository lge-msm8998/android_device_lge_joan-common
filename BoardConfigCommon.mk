#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_COMMON_PATH := device/lge/joan-common

# Inherit common repository
include device/lge/msm8998-common/BoardConfigCommon.mk

# Android Verified Boot
BOARD_AVB_ENABLE := false

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_COMMON_PATH)/manifest.xml

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

# Lights
TARGET_PROVIDES_LIBLIGHT := true
$(call soong_config_set,LGE_LIGHTS_HAL,INCLUDE_DIR,$(DEVICE_COMMON_PATH)/include)

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
BOARD_CACHEIMAGE_PARTITION_SIZE := 536870912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 41943040
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 6157737984
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119267606528
BOARD_FLASH_BLOCK_SIZE := 0x40000
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_COMMON_PATH)/rootdir/etc/fstab.qcom

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# inherit from the proprietary version
include vendor/lge/joan-common/BoardConfigVendor.mk

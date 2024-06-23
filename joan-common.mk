#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_COMMON_PATH := device/lge/joan-common

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_COMMON_PATH)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_COMMON_PATH)/overlay \
    $(DEVICE_COMMON_PATH)/overlay-lineage

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/audio/audio_output_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_output_policy.conf \
    $(DEVICE_COMMON_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(DEVICE_COMMON_PATH)/audio/mixer_paths_tavil.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_tavil.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2880
TARGET_SCREEN_WIDTH := 1440

# Camera
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/configs/camera/camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_config.xml \
    $(DEVICE_COMMON_PATH)/configs/camera/hi553_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/hi553_chromatix.xml \
    $(DEVICE_COMMON_PATH)/configs/camera/imx351_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/imx351_chromatix.xml \
    $(DEVICE_COMMON_PATH)/configs/camera/s5k3m3_chromatix.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/s5k3m3_chromatix.xml

# Fingerprint
PRODUCT_PACKAGES += \
    vendor.lge.hardware.biometrics.fingerprint@2.1.vendor

# HDR
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/configs/hdr_tm_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/hdr_tm_config.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery

# Init
PRODUCT_PACKAGES += \
    fstab.qcom

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Media
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml

# Recovery
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/recovery/root/init.recovery.joan.rc:root/init.recovery.joan.rc

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.lge

# Wifi
PRODUCT_COPY_FILES += \
    $(DEVICE_COMMON_PATH)/wifi/wifi_concurrency_cfg.txt:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wifi_concurrency_cfg.txt

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlan_mac.bin_symlink

# Inherit proprietary blobs
$(call inherit-product, vendor/lge/joan-common/joan-common-vendor.mk)

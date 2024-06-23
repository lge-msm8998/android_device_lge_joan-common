#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
    product/etc/permissions/vendor.qti.hardware.data.connection-V1.*-java.xml)
        sed -i "s/\"2\.0/\"1\.0/g" "${2}"
        ;;
    vendor/lib/hw/camera.msm8998.so)
        sed -i "s/libandroid\.so/libui_shim\.so/g" "${2}"
        ${PATCHELF} --remove-needed libsensor.so "${2}"
        ${PATCHELF} --remove-needed libgui.so "${2}"
        ${PATCHELF} --remove-needed libui.so "${2}"
        ;;
    vendor/lib/libarcsoft_beauty_picselfie.so)
        ${PATCHELF} --remove-needed libandroid.so "${2}"
        ${PATCHELF} --remove-needed libjnigraphics.so "${2}"
        ${PATCHELF} --replace-needed libstdc++.so libstdc++_vendor.so "${2}"
        ;;
    vendor/lib/libfilm_emulation.so)
        ${PATCHELF} --remove-needed libjnigraphics.so "${2}"
        ${PATCHELF} --replace-needed libstdc++.so libstdc++_vendor.so "${2}"
        ;;
    vendor/lib/libmmcamera_bokeh.so)
        ${PATCHELF} --replace-needed libui.so libui_shim.so "${2}"
        ;;
    vendor/lib/libmpbase.so)
        ${PATCHELF} --remove-needed libandroid.so "${2}"
        ${PATCHELF} --replace-needed libstdc++.so libstdc++_vendor.so "${2}"
        ;;
    vendor/lib/libAutoContrast.so|vendor/lib/libSJFingerDetect.so|vendor/lib/libSJVideoNR.so|vendor/lib/libarcsoft_object_tracking.so|vendor/lib/libarcsoft_picselfie_algorithm.so|vendor/lib/libcinemaeffect.so|vendor/lib/libfilm_emulation_symphony.so|vendor/lib/liblghdri.so|vendor/lib/liblgmda.so|vendor/lib/libmorpho_image_stab31.so|vendor/lib/libmorpho_superzoom.so)
        ${PATCHELF} --replace-needed libstdc++.so libstdc++_vendor.so "${2}"
        ;;
    vendor/lib/sensors.ssc.so)
        sed -i "s/\x11\xf0\x9e\xf8/\x4d\xd2\x00\xbf/" "${2}"
        ;;
    vendor/lib64/sensors.ssc.so)
        sed -i "s/\xf2\x8b\xff\x97/\x2a\x00\x00\x14/" "${2}"
        ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE_COMMON=msm8998-common
export DEVICE_SPECIFIED_COMMON_DEVICE="joan l01k"

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"

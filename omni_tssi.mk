#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from tssi device
$(call inherit-product, device/itel/tssi/device.mk)

PRODUCT_DEVICE := tssi
PRODUCT_NAME := omni_tssi
PRODUCT_BRAND := Itel
PRODUCT_MODEL := TSSI
PRODUCT_MANUFACTURER := itel

PRODUCT_GMS_CLIENTID_BASE := android-transsion

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="tssi_arm64_itel_full-user 15 AP3A.240905.015.A2 37103 release-keys"

BUILD_FINGERPRINT := Itel/S685LN-OP/itel-S685LN:15/AP3A.240905.015.A2/165002:user/release-keys

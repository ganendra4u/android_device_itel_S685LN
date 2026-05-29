#
# device.mk - Itel S25 (S685LN)
#

# Installs gsi keys into the ramdisk (untuk GSI support)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B support
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 35

PRODUCT_DEVICE := S685LN
PRODUCT_NAME := omni_S685LN
PRODUCT_BRAND := Itel
PRODUCT_MODEL := itel S25
PRODUCT_MANUFACTURER := ITEL

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=itel_S685LN \
    PRIVATE_BUILD_DESC="S685LN-15.1.2.165SP11(OP001PF001AZ) release-keys"

BUILD_FINGERPRINT := Itel/S685LN/itel-S685LN:15/AP35.240610.016/S685LN-15.1.2.165SP11:user/release-keys

# fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/fstab.ums9230_S685LNV:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_S685LNV \
    $(LOCAL_PATH)/recovery/root/fstab.ums9230_S685LNV:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_S685LNV

# Init RC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.ums9230_S685LNV.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ums9230_S685LNV.rc

# A/B updater
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

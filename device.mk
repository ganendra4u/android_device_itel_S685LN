#
# device.mk — itel S25 (S685LN)
#

PRODUCT_RELEASE_NAME := S685LN

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Dynamic Partitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Shipping API level 34 (first_api_level)

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# VNDK
PRODUCT_USES_DYNAMIC_PARTITIONS := true

# Device-specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=34 \
    ro.crypto.type=file \
    ro.crypto.state=encrypted \
    ro.board.platform=ums9230 \
    ro.sf.lcd_density=480

# Namespaces
PRODUCT_SOONG_NAMESPACES += \
    device/itel/S685LN

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab

# OrangeFox / TWRP tools
TW_INCLUDE_REPACKTOOLS := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/itel/S685LN/device.mk)

PRODUCT_DEVICE   := S685LN
PRODUCT_NAME     := omni_S685LN
PRODUCT_BRAND    := Itel
PRODUCT_MODEL    := itel S685LN
PRODUCT_MANUFACTURER := ITEL

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="ums9230_S685LNV-user 15 AP3A.240905.015.A2 37103 release-keys" \
    BuildFingerprint="Itel/S685LN-OP/itel-S685LN:15/AP3A.240905.015.A2/165002:user/release-keys"

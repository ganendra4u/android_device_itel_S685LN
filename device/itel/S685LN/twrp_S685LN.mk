# Release name
PRODUCT_RELEASE_NAME := S685LN

# Inherit TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device config
$(call inherit-product, device/itel/S685LN/device.mk)

## Device identifier
PRODUCT_NAME := twrp_S685LN
PRODUCT_DEVICE := S685LN
PRODUCT_BRAND := Itel
PRODUCT_MODEL := itel S25
PRODUCT_MANUFACTURER := ITEL

#
# BoardConfig.mk - Itel S25 (S685LN)
# Chipset  : Unisoc UMS9230S
# Maintainer: (Your Name)
#

DEVICE_PATH := device/itel/S685LN

# =========================================================
# Architecture
# =========================================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# =========================================================
# Bootloader
# =========================================================
TARGET_BOOTLOADER_BOARD_NAME := S685LN
TARGET_NO_BOOTLOADER := true

# =========================================================
# Platform / Chipset
# =========================================================
TARGET_BOARD_PLATFORM := ums9230
TARGET_BOARD_PLATFORM_GPU := mali-g57
BOARD_USES_UNISOC_HARDWARE := true

# =========================================================
# Kernel - GKI 5.15 (Prebuilt)
# =========================================================
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz

# NOTE: Isi nilai ini setelah jalankan:
#   cat /proc/cmdline
# di Termux setelah UBL nanti!
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 \
    buildvariant=user

# Nilai GKI standard untuk Unisoc UMS9230
# Verifikasi dengan: cat /proc/cmdline
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET         := 0x01f00000
BOARD_KERNEL_OFFSET      := 0x00008000

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# =========================================================
# A/B Partition - CONFIRMED dari Termux (slot_suffix = _b)
# =========================================================
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    system \
    system_ext \
    vendor \
    vendor_dlkm \
    odm \
    product \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vbmeta_odm \
    vbmeta_product

# =========================================================
# Dynamic Partitions - CONFIRMED dari fstab (logical)
# =========================================================
BOARD_SUPER_PARTITION_GROUPS := itel_dynamic_partitions
BOARD_ITEL_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    vendor \
    vendor_dlkm \
    odm \
    product \
    system_dlkm

# NOTE: Isi ukuran super partition setelah UBL
# Cara cek: adb shell cat /proc/partitions | grep super
# Placeholder: 9GB (sesuaikan!)
BOARD_SUPER_PARTITION_SIZE := 9663676416
BOARD_ITEL_DYNAMIC_PARTITIONS_SIZE := 9659482112

# =========================================================
# Partitions
# =========================================================
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

# NOTE: Sesuaikan ukuran ini setelah UBL via:
# adb shell cat /proc/partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 67108864  # 64MB - VERIFY!
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# System pakai EROFS (confirmed dari fstab)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs

# Userdata pakai f2fs dengan enkripsi (confirmed dari fstab)
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# =========================================================
# AVB (Android Verified Boot)
# =========================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# =========================================================
# Recovery
# =========================================================
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/fstab.ums9230_S685LNV
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USES_MKE2FS := true

# Android 15 / GKI - recovery ada di vendor_boot
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

# =========================================================
# Security / Encryption
# =========================================================
# Enkripsi userdata (confirmed dari fstab):
# aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# Untuk testing awal, disable dulu
TW_INCLUDE_CRYPTO := false
# Aktifkan setelah recovery bisa boot:
# TW_INCLUDE_CRYPTO := true
# TW_INCLUDE_CRYPTO_FBE := true

# =========================================================
# TWRP / SHRP Flags
# =========================================================
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true

# Display (1080x2436 @ 403dpi)
TW_BRIGHTNESS_PATH := "/sys/class/backlight/sprd_backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
TW_NO_SCREEN_BLANK := true

# Device info
TW_DEVICE_VERSION := 0
TW_MANUFACTURER := Itel
TW_DEVICE_NAME := "Itel S25"

# =========================================================
# SHRP Specific Flags (aktifkan kalau build SHRP)
# =========================================================
SHRP_PATH             := $(DEVICE_PATH)
SHRP_MAINTAINER       := YourNameHere
SHRP_DEVICE_CODE      := S685LN
SHRP_EDL_MODE         := 0
SHRP_INTERNAL         := /sdcard
SHRP_EXTERNAL         := /sdcard1
SHRP_OTG              := /usb_otg
SHRP_FLASH            := 1
SHRP_REC              := /dev/block/by-name/recovery
SHRP_REC_TYPE         := AB
SHRP_DEVICE_TYPE      := AB
SHRP_NOTCH            := false
SHRP_EXPRESS          := true
SHRP_DARK             := true
SHRP_AB               := true
SHRP_STATUSBAR_RIGHT  := 48
SHRP_STATUSBAR_LEFT   := 48

# =========================================================
# Debugging
# =========================================================
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += \
    debuggerd \
    strace

# =========================================================
# Misc
# =========================================================
ALLOW_MISSING_DEPENDENCIES := true

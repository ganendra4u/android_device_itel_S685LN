#
# BoardConfig.mk — itel S25 (S685LN) / Unisoc UMS9230S
# SoC    : Spreadtrum/Unisoc UMS9230S
# Kernel : 5.15.189-android13-8 (GKI, raw ARM64, ~45 MB)
# Android: 15 (SDK 35), first API 34
# RAM    : ~8 GB  |  Storage: UFS (~119 GB)
# Display: 1080×2436 @ 120 Hz, density 480
# Parts  : A/B Virtual A/B + Dynamic (super = sda46)
# Crypto : FBE aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized
#
# ── Verified from magiskboot unpack ──────────────────────────────────────────
# boot_a.bin    : HEADER_VER=4, KERNEL_SZ=47442432, RAMDISK_SZ=0, PAGESIZE=4096
# vendor_boot   : HEADER_VER=4, RAMDISK_SZ=34594226, DTB_SZ=134120,
#                 PAGESIZE=4096, CMDLINE="console=ttyS1,115200n8 bootconfig bootconfig"
#                 VND_RAMDISK fmt=lz4_legacy
#

DEVICE_PATH := device/itel/S685LN

# ── Architecture ──────────────────────────────────────────────────────────────
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_ABI2     :=
TARGET_CPU_VARIANT  := cortex-a75

TARGET_2ND_ARCH         := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT  := cortex-a55

# ── Platform ──────────────────────────────────────────────────────────────────
TARGET_BOARD_PLATFORM        := ums9230
TARGET_BOOTLOADER_BOARD_NAME := ITEL-S685LN
TARGET_NO_BOOTLOADER         := true
TARGET_USES_UEFI             := true

# ── Kernel (prebuilt GKI raw Image) ──────────────────────────────────────────
# Kernel fmt = raw (bukan Image.gz), sesuai magiskboot: KERNEL_FMT=[raw]
TARGET_PREBUILT_KERNEL       := $(DEVICE_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBOIMAGE     := $(DEVICE_PATH)/prebuilt/dtbo.img

# CMDLINE dari vendor_boot_stock: "console=ttyS1,115200n8 bootconfig bootconfig"
# Boot partition CMDLINE kosong (GKI style — cmdline ada di vendor_boot)
BOARD_KERNEL_CMDLINE         :=

# Dari magiskboot unpack — pagesize 4096, header v4
# Offset standar Unisoc UMS9230 (tidak ada di header, pakai default GKI)
BOARD_KERNEL_BASE            := 0x00000000
BOARD_KERNEL_PAGESIZE        := 4096
BOARD_KERNEL_OFFSET          := 0x00008000
BOARD_RAMDISK_OFFSET         := 0x05400000
BOARD_KERNEL_TAGS_OFFSET     := 0x00000100
BOARD_DTB_OFFSET             := 0x01f00000

# Kernel format raw (bukan gz/lz4) — KERNEL_FMT=[raw]
BOARD_KERNEL_IMAGE_NAME      := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Header version 4 (GKI 2.0, Android 13+)
BOARD_BOOT_HEADER_VERSION    := 4

BOARD_MKBOOTIMG_ARGS += \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
    --dtb_offset $(BOARD_DTB_OFFSET) \
    --header_version $(BOARD_BOOT_HEADER_VERSION)

# Vendor boot header version juga 4

# ── Partitions ────────────────────────────────────────────────────────────────
# UFS block device /dev/block/sda (124960768 × 1024 = ~119 GB)
# Semua ukuran dari /proc/partitions (× 1024 bytes)

BOARD_FLASH_BLOCK_SIZE := 131072  # pagesize(4096) × 32

# boot_a/b = sda36/37 = 65536 blocks × 1024 = 64 MB
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

# init_boot_a/b = sda40/41 = 8192 blocks × 1024 = 8 MB
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608

# vendor_boot_a/b = sda38/39 = 102400 blocks × 1024 = 100 MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600

# dtbo_a/b = sda44/45 = 8192 blocks × 1024 = 8 MB
BOARD_DTBOIMAGE_PARTITION_SIZE := 8388608

# cache = sda47 = 65536 blocks × 1024 = 64 MB
BOARD_CACHEIMAGE_PARTITION_SIZE := 67108864

# metadata = sda51 = 65536 blocks × 1024 = 64 MB
BOARD_METADATAIMAGE_PARTITION_SIZE := 67108864

# super = sda46 = 8192000 blocks × 1024 = ~7.8 GB
BOARD_SUPER_PARTITION_SIZE := 8388608000
BOARD_SUPER_PARTITION_GROUPS := sprd_dynamic_partitions
BOARD_SPRD_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system system_ext vendor odm product vendor_dlkm system_dlkm
# super size - 4MB overhead
BOARD_SPRD_DYNAMIC_PARTITIONS_SIZE := 8384413696

# userdata = sda75 = 114951168 blocks × 1024 = ~109.6 GB
BOARD_USERDATAIMAGE_PARTITION_SIZE   := 117710507008
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4        := true
TARGET_USERIMAGES_USE_F2FS        := true

# ── A/B (Virtual A/B) ─────────────────────────────────────────────────────────
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot init_boot vendor_boot dtbo \
    l_agdsp l_deltanv l_fixnv1 l_fixnv2 l_gdsp l_ldsp l_modem \
    odm pm_sys product sdc sml \
    system system_dlkm system_ext \
    teecfg trustos uboot \
    vbmeta vbmeta_odm vbmeta_product vbmeta_system \
    vbmeta_system_ext vbmeta_vendor \
    vendor vendor_dlkm

# Tidak ada partisi recovery tersendiri — recovery ada di vendor_boot ramdisk
BOARD_USES_RECOVERY_AS_BOOT              := false

# ── Recovery ──────────────────────────────────────────────────────────────────
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB        := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_HAS_LARGE_FILESYSTEM   := true
BOARD_HAS_NO_SELECT_BUTTON   := true

# ── OrangeFox ─────────────────────────────────────────────────────────────────
OF_SCREEN_H              := 2436
OF_SCREEN_W              := 1080
OF_STATUS_H              := 100
OF_STATUS_INDENT_LEFT    := 48
OF_STATUS_INDENT_RIGHT   := 48
OF_ALLOW_DISABLE_NAVBAR  := 1
OF_CLOCK_POS             := 1
# Tidak ada partisi oem pada device ini
OF_FL_PATH1              := /dev/block/by-name/cache
FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER := 1

# ── AVB (Verified Boot) ───────────────────────────────────────────────────────
BOARD_AVB_ENABLE                            := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS            += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH                 := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM                := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX           := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION  := 1

# ── Encryption ────────────────────────────────────────────────────────────────
# Bypass security patch check agar recovery bisa decrypt FBE
PLATFORM_VERSION             := 99.87.36
PLATFORM_VERSION_LAST_STABLE := 15
PLATFORM_SECURITY_PATCH      := 2099-12-31
VENDOR_SECURITY_PATCH        := 2099-12-31
BOOT_SECURITY_PATCH          := 2099-12-31

TW_INCLUDE_CRYPTO            := true
TW_INCLUDE_CRYPTO_FBE        := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# ── Misc ──────────────────────────────────────────────────────────────────────
TARGET_USES_MKE2FS                             := true
ALLOW_MISSING_DEPENDENCIES                     := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES   := true
TARGET_SUPPORTS_64_BIT_APPS := true

# SDK versions — harus >= PRODUCT_SHIPPING_API_LEVEL (34)

# Include TWRP/OFox flags
-include $(DEVICE_PATH)/twrp.flags

# DTB prebuilt copy rule

# DTB prebuilt — folder berisi file .dtb
BOARD_PREBUILT_DTBIMAGE_DIR  := $(DEVICE_PATH)/prebuilt/dtb

# Vendor symlink fix
RECOVERY_VARIANT := twrp

# Root symlinks
BOARD_ROOT_EXTRA_SYMLINKS := /vendor/lib/dsp:/dsp
BOARD_USES_VENDOR_DLKMIMAGE := false

# Fix rsync vendor conflict
BOARD_RECOVERY_MKBOOTIMG_ARGS := --ramdisk_offset 0x05400000
TARGET_COPY_OUT_RECOVERY := recovery
LZMA_RAMDISK_TARGETS := recovery

# Bootconfig - sesuai stock prop.default
BOARD_BOOTCONFIG := \
    androidboot.hardware=ums9230_S685LNV \
    androidboot.dynamic_partitions=true

# Recovery di vendor_boot - header v4

# Recovery resources di vendor_boot

# Vendor cmdline sesuai stock
BOARD_RAMDISK_USE_LZ4 := true

# Single ramdisk - sesuai stock Unisoc
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_USES_RECOVERY_AS_BOOT := false

# Fix CMDLINE - sesuai stock (bootconfig dua kali)
BOARD_VENDOR_CMDLINE := console=ttyS1,115200n8 bootconfig bootconfig

# Dari repo Massatrio
TW_HAS_DOWNLOAD_MODE := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_NO_RECOVERY := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
TW_USE_FSCRYPT_POLICY := 2
TW_PREPARE_DATA_MEDIA_EARLY := true

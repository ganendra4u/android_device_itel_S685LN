# Device Tree — itel S25 (S685LN)

## Spesifikasi Device
| | |
|---|---|
| Model | itel S25 (itel S685LN) |
| SoC | Unisoc UMS9230S (Spreadtrum) |
| CPU | 6× Cortex-A55 + 2× Cortex-A75 |
| Kernel | 5.15.189-android13-8 GKI, raw Image, ~45 MB |
| Boot header | v4 (GKI 2.0) |
| Vendor boot | v4, ramdisk lz4_legacy, DTB 134 KB |
| RAM | 8 GB |
| Storage | UFS ~119 GB |
| Display | 1080×2436, 120 Hz, density 480 |
| Android | 15 (SDK 35), first API 34 |
| Partisi | Virtual A/B + Dynamic (super = sda46) |
| Enkripsi | FBE aes-256-xts:aes-256-cts:v2+inlinecrypt |

## Partisi Penting
| Nama | Block | Ukuran |
|---|---|---|
| boot_a/b | sda36/37 | 64 MB |
| init_boot_a/b | sda40/41 | 8 MB |
| vendor_boot_a/b | sda38/39 | 100 MB |
| dtbo_a/b | sda44/45 | 8 MB |
| super | sda46 | ~8 GB |
| cache | sda47 | 64 MB |
| metadata | sda51 | 64 MB |
| userdata | sda75 | ~110 GB |

## Persiapan Prebuilt (sudah ada di VPS)

```bash
cd /root

# 1. Kernel sudah ter-extract dari boot_a.bin
#    /root/kernel → copy ke device tree
cp /root/kernel /path/to/device/itel/S685LN/prebuilt/kernel

# 2. DTB dari vendor_boot_unpack
cp /root/vendor_boot_unpack/dtb /path/to/device/itel/S685LN/prebuilt/dtb.img

# 3. DTBO — dump dari device (kalau belum ada)
#    Di Termux device:
#    dd if=/dev/block/by-name/dtbo_b of=/sdcard/dtbo.img bs=4096
#    Lalu SCP ke VPS
cp /root/dtbo.img /path/to/device/itel/S685LN/prebuilt/dtbo.img
```

## Build OrangeFox

```bash
# 1. Sync OrangeFox source (gunakan fox_12.1 atau sesuai)
repo init -u https://gitlab.com/OrangeFox/Manifest.git -b fox_12.1
repo sync

# 2. Taruh device tree
cp -r device_tree_itel_S685LN/device/itel/S685LN device/itel/S685LN

# 3. Copy prebuilt
mkdir -p device/itel/S685LN/prebuilt
cp /root/kernel device/itel/S685LN/prebuilt/kernel
cp /root/vendor_boot_unpack/dtb device/itel/S685LN/prebuilt/dtb.img
cp /root/dtbo.img device/itel/S685LN/prebuilt/dtbo.img

# 4. Build
source build/envsetup.sh
lunch omni_S685LN-eng
mka vendorbootimage -j$(nproc)
```

## Flash

```bash
# Output ada di:
# out/target/product/S685LN/vendor_boot.img

# Flash via fastboot:
fastboot flash vendor_boot_a out/target/product/S685LN/vendor_boot.img
fastboot flash vendor_boot_b out/target/product/S685LN/vendor_boot.img
fastboot reboot recovery
```

## Catatan
- **Tidak ada `recovery` partition** — OFox masuk lewat `vendor_boot`
- **Kernel fmt = raw** (bukan gz), makanya `BOARD_KERNEL_IMAGE_NAME := Image`
- **RAMDISK_SZ = 0 di boot** — semua ramdisk ada di vendor_boot (standar GKI 2.0)
- **CMDLINE kosong di boot** — cmdline ada di vendor_boot: `console=ttyS1,115200n8 bootconfig`
- Jika ada masalah decrypt data, perlu copy vendor modules ke vendor_boot ramdisk

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


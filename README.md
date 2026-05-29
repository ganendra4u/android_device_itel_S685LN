# Device Tree - Itel S25 (S685LN)

> **⚠️ Work In Progress** — Pioneer device tree

## Spesifikasi Device

| Spec | Detail |
|------|--------|
| **Model** | Itel S25 |
| **Codename** | S685LN |
| **Chipset** | Unisoc UMS9230S |
| **CPU** | 2x ARM Cortex-A75 @ 2.21GHz + 6x ARM Cortex-A55 @ 1.82GHz |
| **GPU** | ARM Mali-G57 |
| **RAM** | 8 GB |
| **Storage** | 128 GB |
| **Display** | 6.61 inch, 1080x2436 px, 403 dpi |
| **Android** | 15 (API 35) |
| **Kernel** | 5.15.189 GKI |
| **Partition** | A/B + Dynamic Partitions |
| **Filesystem** | EROFS (system), F2FS (data) |
| **Encryption** | FBE aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized |

## Status

| Feature | Status |
|---------|--------|
| Booting | ❔ Testing |
| ADB | ❔ Testing |
| MTP | ❔ Testing |
| Decryption | ❌ TODO |
| Flash ZIP | ❔ Testing |
| Backup/Restore | ❔ Testing |
| External SD | ❔ Testing |

## Build Instructions

### Requirements
- Ubuntu 20.04 / 22.04 LTS
- 16GB RAM minimum (32GB recommended)
- 200GB free storage
- Python 3.x

### Steps

```bash
# 1. Install dependencies
sudo apt install git-core gnupg flex bison build-essential zip curl \
  zlib1g-dev libc6-dev-i386 libncurses5 lib32ncurses5-dev \
  x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
  libxml2-utils xsltproc unzip fontconfig python3 python-is-python3 bc

# 2. Install repo
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

# 3. Sync TWRP source
mkdir twrp && cd twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git \
  -b twrp-12.1 --depth=1
repo sync -j$(nproc) --force-sync --no-clone-bundle

# 4. Clone device tree
git clone https://github.com/ganendra4u/device_itel_S685LN device/itel/S685LN

# 5. Copy prebuilt kernel (ekstrak dari stock ROM / boot.img dulu)
# cp kernel device/itel/S685LN/prebuilt/kernel

# 6. Build
source build/envsetup.sh
lunch twrp_S685LN-eng
mka recoveryimage -j$(nproc)
```

### Flash

```bash
# Pastikan bootloader sudah di-unlock!
adb reboot bootloader
fastboot flash vendor_boot out/target/product/S685LN/vendor_boot.img
fastboot reboot recovery
```

## Notes

- Kernel cmdline dan ukuran partisi perlu diverifikasi ulang setelah UBL
- Lihat `BoardConfig.mk` untuk bagian yang masih perlu diisi (`# NOTE:`)

## Maintainer

- **[ganendra4u]** - [@GitHub](https://github.com/ganendra4u)

## Credits

- TWRP Team
- Unisoc device tree references
- XDA Community

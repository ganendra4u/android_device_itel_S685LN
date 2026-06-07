#!/system/bin/sh
# extract_prebuilt.sh
# Jalankan di Termux (su) untuk extract kernel, dtb, dtbo dari device
# Output: /sdcard/ofox_prebuilt/

set -e
OUT=/sdcard/ofox_prebuilt
mkdir -p "$OUT"

echo "[*] Dumping boot_b..."
dd if=/dev/block/by-name/boot_b   of="$OUT/boot_b.img"   bs=4096

echo "[*] Dumping dtbo_b..."
dd if=/dev/block/by-name/dtbo_b   of="$OUT/dtbo_b.img"   bs=4096

echo "[*] Dumping dtb_b..."
dd if=/dev/block/by-name/dtb_b    of="$OUT/dtb_b.img"    bs=4096

echo "[*] Dumping vendor_boot_b..."
dd if=/dev/block/by-name/vendor_boot_b of="$OUT/vendor_boot_b.img" bs=4096

echo ""
echo "[!] Selesai. File ada di $OUT"
echo "[!] Selanjutnya:"
echo "    1. Copy file ke PC"
echo "    2. Unpack boot_b.img dengan magiskboot:"
echo "       magiskboot unpack boot_b.img"
echo "    3. Copy 'kernel' hasil unpack ke device/itel/S685LN/prebuilt/kernel"
echo "    4. Copy dtb_b.img  ke device/itel/S685LN/prebuilt/dtb.img"
echo "    5. Copy dtbo_b.img ke device/itel/S685LN/prebuilt/dtbo.img"

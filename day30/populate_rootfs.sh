#!/bin/bash
# Day 30 Mini-Container Setup Script
# Copies essential binaries + their libraries into rootfs

set -e

# Paths
ROOTFS="$HOME/linux_lab/day30/rootfs"
BINARIES=(/bin/bash /bin/ls /bin/cat /bin/ps /bin/ping)

# Ensure rootfs directories exist
mkdir -p "$ROOTFS"/{bin,lib,lib64,proc}

echo "[*] Copying binaries..."
for BIN in "${BINARIES[@]}"; do
    cp "$BIN" "$ROOTFS/bin/"
done

echo "[*] Copying libraries..."
for BIN in "${BINARIES[@]}"; do
    LIBS=$(ldd "$BIN" | awk '{if ($3 ~ /^\//) print $3}')
    for LIB in $LIBS; do
        DEST="$ROOTFS/lib"
        [[ "$LIB" == /lib64/* || "$LIB" == /lib/x86_64-linux-gnu/* && "$LIB" =~ ld-linux ]] && DEST="$ROOTFS/lib64"
        cp "$LIB" "$DEST/"
    done
done

echo "[*] Setup complete!"
echo "rootfs now contains bash, ls, cat, ps, ping + all required libraries."
echo "You can now run your mini-container:"
echo "sudo unshare --fork --pid --mount --uts --ipc --net bash"
echo "mount -t proc proc $ROOTFS/proc"
echo "sudo chroot $ROOTFS /bin/bash"

#! /usr/bin/env  bash

set -xeuo pipefail
trap cleanup EXIT

pushd $(dirname $0)
SCRIPT_PATH=$(pwd)
popd

DISK=/dev/sda
EFI_PART="$DISK"1
EFI_MNT=/mnt/boot

cleanup() {
  umount "$EFI_MNT" || true
}

cleanup

# Bootstrap nixos
mkdir -p "$EFI_MNT" || true
mount "$EFI_PART" "$EFI_MNT"
rm -rf /mnt/etc/nixos || true
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix $SCRIPT_PATH/nix/
rm -rf /mnt/etc/nixos && mkdir -p /mnt/etc/nixos
cp -rf -t /mnt/etc/nixos $SCRIPT_PATH/nix/*
ln -sf /mnt/etc/nixos/machines/engineer.nix /mnt/etc/nixos/machine.nix
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nixos-install --no-root-passwd
$SCRIPT_PATH/post-install.sh

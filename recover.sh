#! /usr/bin/env  bash

set -xeuo pipefail
trap cleanup EXIT

pushd $(dirname $0)
SCRIPT_PATH=$(pwd)
popd

DISK=/dev/sda
LUKS_ROOT=luks-root
EFI_PART="$DISK"1
EFI_MNT=/mnt/boot
FS_ROOT=fs-root

cleanup() {
  umount "$EFI_MNT" || true
}

yubi_run() {
  nix-shell https://codeload.github.com/sgillespie/nixos-yubikey-luks/tar.gz/master --run "$1"
}

luks() {

  KEY_LENGTH=512
  ITERATIONS=1000000
  LUKS_PART="$DISK"2
  STORAGE=/crypt-storage/default
  SLOT=2
  SALT_LENGTH=16
  CIPHER=xts-aes-xtsproxy-plain64
  HASH=sha512

  mkdir -p "$EFI_MNT"
  mount "$EFI_PART" "$EFI_MNT"
  salt=$(head -1 "$EFI_MNT$STORAGE")
  umount "$EFI_MNT"

  read -p "Disk passphrase: " -s k_user

  challenge=$(yubi_run "echo -n $salt | openssl dgst -binary -sha512 | rbtohex")
  response=$(yubi_run "ykchalresp -2 -x $challenge 2>/dev/null")
  k_luks=$(yubi_run "echo -n \"$k_user\" | pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $response | rbtohex")

  yubi_run "echo -n \"$k_luks\" | hextorb | cryptsetup luksOpen $LUKS_PART $LUKS_ROOT --key-file=-"
}

################

cleanup

# Mounts
luks
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=lzo,space_cache,subvol=subvolume-root "/dev/mapper/$LUKS_ROOT" /mnt
mount "$EFI_PART" "$EFI_MNT"

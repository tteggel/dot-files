#!/usr/bin/env bash

set -xeuo pipefail
trap cleanup EXIT

cleanup() {
  umount "$EFI_MNT" || true
  rm -f keyfile || true
}

rbtohex() {
    ( od -An -vtx1 | tr -d ' \n' )
}

hextorb() {
    ( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI' | xargs printf )
}

DISK=/dev/sda
LUKS_ROOT=luks-root
EFI_PART="$DISK"1
EFI_MNT=/mnt/boot
FS_ROOT=fs-root

KEY_LENGTH=512
ITERATIONS=1000000
LUKS_PART="$DISK"2
STORAGE=/crypt-storage/default

mkdir -p "$EFI_MNT"
mount "$EFI_PART" "$EFI_MNT"
salt=$(head -1 "$EFI_MNT$STORAGE")
umount "$EFI_MNT"

stty -echo
read -p "Disk passphrase: " -s k_user

challenge=$(echo -n $salt | openssl dgst -binary -sha512 | rbtohex)
response=$(ykchalresp -2 -x $challenge 2>/dev/null)
#response="a"
k_luks=$(echo -n "$k_user" | pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $response | rbtohex)

keyid=$(dmsetup table "$LUKS_ROOT" --showkeys | awk '{print $5}' | cut -d: -f5)
#keyctl link $(keyctl list @u | grep $keyid | cut -d: -f1) @t


echo -n "$k_luks" > keyfile
cryptsetup luksConvertKey /dev/sda2 --keyslot-cipher xts-aes-xtsproxy-plain64 --pbkdf pbkdf2 --key-file=keyfile

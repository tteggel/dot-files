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
  umount /mnt/boot || true
  umount /mnt || true
  umount /boot || true
  cryptsetup close "$LUKS_ROOT" || true
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
  CIPHER=aes-xts-plain64
  HASH=sha512

  salt=$(yubi_run "dd if=/dev/random bs=1 count=$SALT_LENGTH 2>/dev/null | rbtohex")
  read -p "Disk passphrase: " -s k_user
  read -p "Confirm disk passphrase: " -s k_user_again
  [[ $k_user = $k_user_again ]] || (echo "Passphrases don't match"; false)

  challenge=$(yubi_run "echo -n $salt | openssl dgst -binary -sha512 | rbtohex")
  response=$(yubi_run "ykchalresp -2 -x $challenge 2>/dev/null")
  k_luks=$(yubi_run "echo -n \"$k_user\" | pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $response | rbtohex")

  mkdir -p "$(dirname $EFI_MNT$STORAGE)"
  echo -ne "$salt\n$ITERATIONS" > $EFI_MNT$STORAGE

  yubi_run "echo -n \"$k_luks\" | hextorb | cryptsetup luksFormat --cipher=\"$CIPHER\" --key-size=\"$KEY_LENGTH\" \
                                  --hash=\"$HASH\" --key-file=- \"$LUKS_PART\""
  yubi_run "echo -n \"$k_luks\" | hextorb | cryptsetup luksOpen $LUKS_PART $LUKS_ROOT --key-file=-"
}

################

cleanup

# EFI partition
parted -s $DISK mklabel gpt
parted -s $DISK mkpart primary fat32 1MiB 1GiB
parted -s $DISK set 1 esp on
parted -s $DISK set 1 boot on
mkfs.vfat -n BOOT "$EFI_PART"

# Encrypted partition
parted $DISK mkpart primary btrfs 1GiB 100%
luks
mkfs.btrfs -f -L "$FS_ROOT" "/dev/mapper/$LUKS_ROOT"

# Root filesystem
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=lzo,space_cache "/dev/mapper/$LUKS_ROOT" /mnt
btrfs subvolume create /mnt/subvolume-root
umount /mnt
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=lzo,space_cache,subvol=subvolume-root "/dev/mapper/$LUKS_ROOT" /mnt
btrfs subvolume create /mnt/var
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/tmp
btrfs subvolume create /mnt/run
btrfs subvolume create /mnt/nix

# Bootstrap nixos
rm -rf "$EFI_MNT" || true
mkdir "$EFI_MNT"
mount "$EFI_PART" "$EFI_MNT"
nixos-generate-config --root /mnt
cp -f $SCRIPT_PATH/nix/configuration.nix /mnt/etc/nixos/
cp -f $SCRIPT_PATH/nix/machines/blank.nix /mnt/etc/nixos/machine.nix
cp -rf $SCRIPT_PATH/nix/pkgs /mnt/etc/nixos/
nixos-install

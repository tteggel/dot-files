#! /usr/bin/env  bash

set -xeuo pipefail
trap cleanup EXIT

pushd $(dirname $0)
SCRIPT_PATH=$(pwd)
popd

cleanup () {
  umount /mnt/etc/resolv.conf || true
}

################

cleanup

rm -rf /mnt/etc/nixos || true
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix $SCRIPT_PATH/nix/hardware-configuration.nix

rm -rf /mnt/home/tteggel/src/github.com/tteggel/dot-files || true
mkdir -p /mnt/home/tteggel/src/github.com/tteggel/dot-files
cp -r $SCRIPT_PATH /mnt/home/tteggel/src/github.com/tteggel
nixos-enter -c "chown -R tteggel:users /home/tteggel/src"

rm -rf /mnt/etc/nixos
nixos-enter -c "ln -s /home/tteggel/src/github.com/tteggel/dot-files/nix /etc/nixos"

touch /mnt/etc/resolv.conf
mount -o bind,ro /etc/resolv.conf /mnt/etc/resolv.conf
nixos-enter -c "sudo -u tteggel /home/tteggel/src/github.com/tteggel/dot-files/setup.sh engineer"

read -p "Press a key to continue then touch Yubi..." -n1
mkdir -p "/mnt/home/tteggel/.config/Yubico"
nix run nixpkgs.pam_u2f -c  pamu2fcfg -u tteggel -o "pam://thomnixe" -i "pam://thomnixe"> /mnt/home/tteggel/.config/Yubico/u2f_keys

nixos-enter -c "chown -R tteggel:users /home/tteggel"

nixos-enter -c "sudo -u tteggel ssh-keygen -b 4096 -t rsa -f /home/tteggel/.ssh/id_rsa -q -N \"\""
nixos-enter -c "sudo -u tteggel git config --global user.email \"thom@tteggel.org\"; git config --global user.name \"Thom Leggett\""

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
mkdir -p /mnt/etc/nixos
nixos-enter -c "find /home/tteggel/src/github.com/tteggel/dot-files/nix -maxdepth 1 -exec ln -s {} /etc/nixos \;"

mount -o bind,ro /etc/resolv.conf /mnt/etc/resolv.conf
nixos-enter -c "su tteggel -c '/home/tteggel/src/github.com/tteggel/dot-files/setup.sh engineer'"

nixos-enter -c "nixos-rebuild switch"

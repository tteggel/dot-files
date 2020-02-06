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
nixos-enter -c "su tteggel -c '/home/tteggel/src/github.com/tteggel/dot-files/setup.sh engineer'"
echo -n "Adding yubikey..."
nixos-enter -c "su tteggel -c 'mkdir -p /home/tteggel/.config/Yubico && pamu2fcfg > /home/tteggel/.config/Yubico/u2f_keys'"
nixos-enter -c "su tteggel -c 'ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N \'\''"
nixos-enter -c "su tteggel -c 'git config --global user.email \"thom@tteggel.org\"; git config --global user.name \"Thom Leggett\"'"

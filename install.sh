# Bootstrap nixos
umount "$EFI_MNT" || true
mkdir -p "$EFI_MNT" || true
mount "$EFI_PART" "$EFI_MNT"
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix $SCRIPT_PATH/nix/
rm -rf /mnt/etc/nixos && mkdir -p /mnt/etc/nixos
cp -rf -t /mnt/etc/nixos $SCRIPT_PATH/nix/*
ln -sf /mnt/etc/nixos/machines/engineer.nix /mnt/etc/nixos/machine.nix
nixos-install --no-root-passwd
$SCRIPT_PATH/post-install.sh

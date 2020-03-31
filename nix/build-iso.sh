#!/usr/bin/env bash
env NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz \
  nix-build '<nixpkgs/nixos>' --no-out-link --show-trace \
    -A config.system.build.isoImage \
    -I nixos-config=iso.nix 

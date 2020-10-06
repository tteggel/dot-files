# env NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix --no-out-link --show-trace
{ config, lib, pkgs, ... }:

{

nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {

      pbkdf2-sha512 = pkgs.callPackage ./pkgs/pbkdf2-sha512 {};

      linuxPackages_latest = pkgs.linuxPackages_latest.extend (self: super: {
        kernel = super.kernel.override {
          kernelPatches = super.kernel.kernelPatches ++ [
            rec {
              name = "0023-Add-DM_CRYPT_FORCE_INLINE-flag-to-dm-crypt-target";
              patch = pkgs.fetchpatch {
                name = name + ".patch";
                url = "https://raw.githubusercontent.com/cloudflare/linux/master/patches/" + name + ".patch";
                sha256 = "1yiw6xzxnigz3ii9afd2409mfl0qx46lj4c7nqq4186ik87cvi3c";
              };
            }

            rec {
              name = "0024-Add-xtsproxy-Crypto-API-module";
              patch = pkgs.fetchpatch {
                name = name + ".patch";
                url = "https://raw.githubusercontent.com/cloudflare/linux/master/patches/" + name + ".patch";
                sha256 = "0cy8784k6p2z37h4jgzv6il6pfxvx18wbgn95gdz2yd33rz43rc9";
              };
            } 
          ];
        };
      });
    };
  };


  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "xtsproxy" ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];

}

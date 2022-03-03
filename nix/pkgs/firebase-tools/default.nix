{ pkgs ? import <nixpkgs> {}, nodejs ? pkgs.nodejs, stdenv ? pkgs.stdenv}:

let
  nodePackages_16_x = import ./composition-v16.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };  

  nodePackages_14_x = import ./composition-v14.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };
in
nodePackages_14_x.firebase-tools

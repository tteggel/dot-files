{ pkgs ? import <nixpkgs> {}, nodejs ? pkgs.nodejs, stdenv ? pkgs.stdenv}:

let
  nodePackages_10_x = import ./composition-v10.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };

  nodePackages_12_x = import ./composition-v12.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };  

  nodePackages_14_x = import ./composition-v14.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };
in 
nodePackages_12_x.playwright.override {
    postInstall = "npm run-script install";
}

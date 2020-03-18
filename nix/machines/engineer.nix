{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      jetbrains.jdk
      jetbrains.webstorm
 
      google-chrome
      google-chrome-dev
      #gitPkgs.chromium-git_82

      slack

      google-cloud-sdk
      firebase-tools

      nodejs
      yarn
      mocha
      nodePackages.node2nix
      playwright

      inkscape

      gcc
      binutils
      dep
      gnumake      
      tree
      smith
      openssl
      jq
      libffi
      bat
      lsof

      go
   ];
  };
}

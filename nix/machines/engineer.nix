{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      jetbrains.jdk
      jetbrains.webstorm
      jetbrains.pycharm-professional
 
      google-chrome
      #google-chrome-dev
      firefox
      firefox-devedition-bin

      slack

      google-cloud-sdk
      firebase-tools
      bower
      gulp
      lerna

      nodejs
      yarn
      mocha
      nodePackages.node2nix
      
      ngrok

      inkscape

      gcc
      binutils
      dep
      gnumake      
      tree
      openssl
      jq
      libffi
      bat
      lsof

      go

      git-lfs

      kubectl
   ];
  };
}

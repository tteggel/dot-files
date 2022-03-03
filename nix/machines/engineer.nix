{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      jetbrains.jdk
      jetbrains.webstorm
      jetbrains.pycharm-professional
 
      google-chrome
      google-chrome-dev
#      firefox
#      firefox-devedition-bin

      slack

      google-cloud-sdk
      firebase-tools

      nodejs
      yarn
#      mocha
      nodePackages.node2nix
      
      ngrok

      inkscape

      gcc
      binutils
      dep
      gnumake      
      tre-command
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

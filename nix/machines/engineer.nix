{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      unstable.jetbrains.jdk
      unstable.jetbrains.webstorm
 
      unstable.firefox
      unstable.google-chrome

      google-cloud-sdk
      firebase-tools

      nodejs
      unstable.yarn
      mocha
      unstable.nodePackages.node2nix

      gcc
      binutils
      go
      dep
      gnumake      
      tree
      smith
      openssl
      jq
      libffi
      bat
   ];
  };
}

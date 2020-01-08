{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      unstable.idea.idea-ultimate
      unstable.jetbrains.goland
      unstable.jetbrains.jdk
      unstable.jetbrains.pycharm-professional
      unstable.jetbrains.ruby-mine
      unstable.jetbrains.webstorm
 
      unstable.firefox
      unstable.google-chrome

      unstable.google-cloud-sdk
      firebase-tools

      nodejs
      yarn
      unstable.nodePackages.mocha
      nodePackages.node2nix

      gcc
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

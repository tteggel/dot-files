{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      unstable.jetbrains.jdk
      unstable.jetbrains.webstorm
 
      google-chrome-dev
      #gitPkgs.chromium-git_82

      unstable.slack

      google-cloud-sdk
      firebase-tools

      nodejs
      unstable.yarn
      mocha
      unstable.nodePackages.node2nix
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
   ];
  };
}

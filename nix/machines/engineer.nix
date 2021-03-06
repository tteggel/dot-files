{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      jetbrains.jdk
      jetbrains.webstorm
 
      google-chrome
      google-chrome-dev
#      firefox
      firefox-devedition-bin
      #gitPkgs.chromium-git_82

      slack
#      spotify

      google-cloud-sdk
      firebase-tools
      bower
      gulp
      lerna

      nodejs
      yarn
      mocha
      nodePackages.node2nix
#      artillery
      #playwright
      
      ngrok

      inkscape

      gcc
      binutils
      dep
      gnumake      
      tree
#      smith
      openssl
      jq
      libffi
      bat
      lsof

      go

      git-lfs

      #ffmpeg-full
   ];
  };
}

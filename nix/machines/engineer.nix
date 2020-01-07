{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      gcc
      idea.idea-ultimate
      jetbrains.goland
      jetbrains.jdk
      jetbrains.pycharm-professional
      jetbrains.ruby-mine
      jetbrains.webstorm
      go
      dep
      gnumake      
      tree
      smith
      chromium
      openssl
      firefox
      jq
      libffi
      bat
      nodejs
      yarn
    ];
  };
}

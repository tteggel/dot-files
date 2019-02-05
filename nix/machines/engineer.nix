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
      go
      dep
      gnumake      
      tree
      smith
      chromium
      kubectl
      openssl
      kubernetes-helm
      firefox
    ];

    virtualisation.virtualbox.host.enable = true;
  };
}

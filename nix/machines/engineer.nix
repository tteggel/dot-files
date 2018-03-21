{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      gcc
      go
      idea.idea-ultimate
      jetbrains.jdk
      tree
      smith
      chromium
    ];

    virtualisation.virtualbox.host.enable = true;
  };
}
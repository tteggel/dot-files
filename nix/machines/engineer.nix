{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      gcc
      go
      idea.idea-ultimate
      tree
      smith
      chromium
    ];
  };
}
{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      slack
      thunderbird
    ];
  };
}
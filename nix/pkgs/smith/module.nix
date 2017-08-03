{ config, pkgs, lib ? pkgs.lib, ... }:

with lib;

let
  smithPackage = (import ./. {});
in
{
  config = {
    environment.systemPackages = [ smithPackage ];
  };
}
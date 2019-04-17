{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.proxy-pac-proxy;
  pkg = pkgs.callPackage ./derivation.nix{};
in {

  options.services.proxy-pac-proxy = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If enabled, run a local proxy with upstreams defined in a PAC.
      '';
    };

    pac = mkOption {
      type = types.str;
      default = "http://wpad.oraclecorp.com/wpad.dat";
      example = "http://proxy/proxy.dat";
      description = ''
        The URL of the PAC file.
      '';
    };
  };

  config = {
    systemd.services.proxy-pac-proxy = mkIf cfg.enable {
      enable = true;
      description = "Local PAC proxy";
      path = with pkgs; [stdenv nix curl netcat];
      wantedBy = [ "multi-user.target" ];
      requires = [ "network-online.target" ];
      wants = [ "network-online.target" "sys-subsystem-net-devices-eth0.device" ];
      bindsTo = [ "sys-subsystem-net-devices-eth0.device" ];
      after = [ "network-online.target" ];

      environment = {
        NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
        no_proxy = "127.0.0.1,localhost,wpad";
      };

      script = ''
        set -xe
        set -o pipefail
        status=$(http_proxy="" curl -s ${cfg.pac} > /dev/null 2>&1; echo $?)
        if [ $status -eq 0 ]; then
          ${pkg.proxy-pac-proxy}/bin/proxy-pac-proxy start --url ${cfg.pac} -p 3128 -f
        else
          ((echo -e "HTTP/1.1 200 OK\r\n"; echo -e "function FindProxyForURL(u,h){return 'DIRECT';}") | nc -lN 8077)&
          ${pkg.proxy-pac-proxy}/bin/proxy-pac-proxy start --url http://localhost:8077 -p 3128 -f
        fi
      '';

      serviceConfig = {
        Type = "simple";
      };

    };
  };
}
{ config, pkgs, ... }:
  
{
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      /etc/nixos/hardware-configuration.nix

#      /etc/nixos/pkgs/squid/module.nix

      /etc/nixos/squid.nix

      /etc/nixos/machine.nix
    ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    initrd.checkJournalingFS = false;
  };

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  networking = {
    hostName = "nixos";
    proxy.default = "http://10.10.10.10:3128";
    proxy.noProxy = "127.0.0.1,10.10.10.10,localhost,wpad-admin.oraclecorp.com";
    firewall.enable = false;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  security.pki.certificates = [
  ''
  Oracle SSL CA
  -----BEGIN CERTIFICATE-----
  MIIFGTCCBAGgAwIBAgIQMTW7fm3iZjqw4jPmsOGlzDANBgkqhkiG9w0BAQsFADCB
  yjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQL
  ExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBWZXJp
  U2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxW
  ZXJpU2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0
  aG9yaXR5IC0gRzUwHhcNMTUwMTA2MDAwMDAwWhcNMjUwMTA1MjM1OTU5WjBoMQsw
  CQYDVQQGEwJVUzEbMBkGA1UEChMST3JhY2xlIENvcnBvcmF0aW9uMR8wHQYDVQQL
  ExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMRswGQYDVQQDExJPcmFjbGUgU1NMIENB
  IC0gRzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCl+XP8hR4j19Bd
  BoAAA0jw6CtZYh9iXvWrY/NJRLR9YCF7Y/FS2uPSsyF1O6oNdAPr2AYJXViBdUdi
  iLiYuR/IYsWrvI1n1giUyyn7vro5X2ihOiUZBcAo47VmvDSyGsv9f4Xz2bfgqczT
  d73jPOGXApw3ecMtD8LOhKu6oWIw4WJIGwoYdld5a99K3ns/NqFP98fEyd4/pJs+
  0CGemzeL2FCp2ewrjRZ0aPF4w7A/cyBbyfqmQQwFv/LDy/uUMeX07izLEy9En9Sr
  LXk2IZKE1qXRjni4cvM/kFwXDuEQqwT40lTVO6T/Dnlh2REfoBDa0KYsftjBMicf
  pTETb8lLAgMBAAGjggFaMIIBVjAuBggrBgEFBQcBAQQiMCAwHgYIKwYBBQUHMAGG
  Emh0dHA6Ly9zLnN5bWNkLmNvbTASBgNVHRMBAf8ECDAGAQH/AgEAMGUGA1UdIARe
  MFwwWgYKYIZIAYb4RQEHNjBMMCMGCCsGAQUFBwIBFhdodHRwczovL2Quc3ltY2Iu
  Y29tL2NwczAlBggrBgEFBQcCAjAZGhdodHRwczovL2Quc3ltY2IuY29tL3JwYTAv
  BgNVHR8EKDAmMCSgIqAghh5odHRwOi8vcy5zeW1jYi5jb20vcGNhMy1nNS5jcmww
  DgYDVR0PAQH/BAQDAgEGMCgGA1UdEQQhMB+kHTAbMRkwFwYDVQQDExBTeW1hbnRl
  Y1BLSS0yLTI1MB0GA1UdDgQWBBRgjGaRX0nIVR/mtZoMeldlczi0ojAfBgNVHSME
  GDAWgBR/02Wnwt3su/AwCfNDOfoCrzMxMzANBgkqhkiG9w0BAQsFAAOCAQEAhkA8
  XUX41+6VCzk6cMyLUsV1hFynLnvE6+XO8QZwLSfsOlaULaiuSgMlO+mVwFhDVfx6
  3L9O9NQI9aNsWwg2jx7VRdYq+HAiCfNDI1RWFSZH6cNAp/odi1QQZcu5TWhaa+iC
  k4swdqbFNp562aqlvz/pYY8k19bNHpeUb1TmaXA0M0J/2X6voQZJk4+djcugw+q9
  Achu7VdHwftj0DnC6tpItWVMWoTqULZEFJb5GXt6F1hOihyGR5gQjkqQCCOCy8L6
  NnDZrEiqhx1sFVmhZgmZTN/XcQKYrVcBwrCrH9ZKc0yUDHnCvbBWe3OZ+4jsE5xL
  QerozOtT8JoZ/72C+Q==
  -----END CERTIFICATE-----
  ''
  ];

  time.timeZone = "Europe/London";

  nixpkgs.config.packageOverrides = pkgs: rec {
    docker = pkgs.docker-edge;
    smith = pkgs.callPackage /etc/nixos/pkgs/smith {};
  };

  environment.systemPackages = with pkgs; [
    emacs

    git
    unzip
    termite
    tmux
    zsh
    python27Packages.powerline
    python3Packages.lxml
    python3Packages.requests

    aspell
    aspellDicts.en

    dmenu
    i3status
    
    htop

    squid
  ];

  virtualisation.docker = {
    enable = true;
    extraOptions = "--mtu=1290";
  };

  services = {
    vmwareGuest.enable = true;

    printing.enable = true;

    emacs.enable = true;

    xserver = {
      enable = true;
      layout = "gb";

      windowManager = { 
        i3.enable = true;
        default = "i3";
      };

      desktopManager = {
        xterm.enable = false;
        default = "none";
      };

      displayManager = {
        auto = {
          enable = true;
          user = "tteggel";
        };
      };

    };
  };

  programs = {
    zsh.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = [ pkgs.nerdfonts ];
  };

  users.extraUsers.tteggel = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["wheel" "input" "audio" "video" "docker"];
    shell = pkgs.zsh;
  };

  fileSystems."/home/tteggel/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:Shared";
    options = [ "nofail" "allow_other" "uid=1000" "gid=1000" "auto_unmount" "defaults" ];
  };

  nix = {
    useSandbox = true;
    buildCores = 0;  # 0 means auto-detect number of CPUs (and use all)

    extraOptions = ''
      # To not get caught by the '''"nix-collect-garbage -d" makes
      # "nixos-rebuild switch" unusable when nixos.org is down"''' issue:
      gc-keep-outputs = true
      # For 'nix-store -l $(which vim)'
      log-servers = http://hydra.nixos.org/log
      # Number of seconds to wait for binary-cache to accept() our connect()
      connect-timeout = 15
    '';

    # Automatic garbage collection
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 14d";
  };

  systemd.services.wpad = {
    enable = true;
    description = "Detect proxy config";
    path = with pkgs; [stdenv nix bash python3 pythonPackages.requests pythonPackages.lxml iproute];
    wantedBy = [ "multi-user.target" ];
    requires = [ "dhcpcd.service" ];
    after = [ "dhcpcd.service" ];
    environment = {
      NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      no_proxy = "127.0.0.1,localhost,wpad-admin.oraclecorp.com";
    };
    script = ''
      ip a add dev lo 10.10.10.10 || true
      /home/tteggel/.dotfiles/gen-proxy.py > /home/tteggel/.dotfiles/squid-parents.conf
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  system.stateVersion = "17.03";

}

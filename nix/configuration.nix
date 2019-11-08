{ config, pkgs, options, ... }:
  
{
  nixpkgs = {
    config.allowUnfree = true;
  };

  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./machine.nix
      ./pkgs/proxy-pac-proxy/module.nix
    ];

  boot = {
      loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
      };
      kernelParams = [ "elevator=noop" ];
      kernelPackages = pkgs.linuxPackages_latest;
      initrd.checkJournalingFS = false;
  };

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  networking = {
    hostName = "thonix";
    proxy.default = "http://127.0.0.1:3128";
    proxy.noProxy = "127.0.0.1,localhost";
    timeServers = options.networking.timeServers.default ++ [ "gdsntp.us.oracle.com" "gdsntp.uk.oracle.com" ];
    firewall.enable = false;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  security = {
    pki.certificates =
      [''
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
      '']
      ++
      (let
        d=~/.dotfiles/third_party/sparta-pki/trustroots;
        l=builtins.readDir d;
        f=builtins.attrNames l;
       in
        map (a: builtins.readFile "${d}/${a}") f
      );
  };

time.timeZone = "Europe/London";

  nixpkgs.config.packageOverrides = pkgs: rec {
    docker = pkgs.docker-edge;
    smith = pkgs.callPackage ./pkgs/smith {};
  };

  virtualisation = {
    vmware.guest.enable = true;
    docker = {
      enable = true;
      extraOptions = "--mtu=1290";
    };
  };

  services = {
    printing.enable = true;

    emacs.enable = true;

    xserver = {
      enable = true;
      layout = "gb";
      videoDrivers = [ "vmware" ];
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
      windowManager = {
        i3.enable = true;
        default = "i3";
      };
    };

    udev = {
      extraRules = ''
        SUBSYSTEM=="tty", GROUP="dialout"
      '';
      packages = with pkgs; [
        yubikey-personalization
      ];
    };

    pcscd.enable = true;

    proxy-pac-proxy.enable = true;

  };

  programs = {
    zsh.enable = true;
    ssh = {
      extraConfig = ''
        ProxyCommand /run/current-system/sw/bin/nc -X connect -x 127.0.0.1:3128 %h %p
        ServerAliveInterval 10
        '';
      startAgent = false;
    };
  };

  environment = {
    systemPackages = with pkgs; [
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

      yubikey-personalization
      opensc
      keybase
    ];

    shellInit = ''
      OPENSC_PATH=$(nix-build '<nixpkgs>' --no-build-output -A opensc)
      eval $(ssh-agent -s -P $OPENSC_PATH/lib/opensc-pkcs11.so)
    '';

  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = [ pkgs.nerdfonts ];
  };

  fileSystems."/home/tteggel/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:Shared";
    options = [ "nofail" "allow_other" "uid=1000" "gid=100" "auto_unmount" "defaults" ];
  };

  users = {
    extraUsers.tteggel = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = ["wheel" "input" "audio" "video" "docker" "dialout"];
      shell = pkgs.zsh;
    };
    groups = { dialout = {}; };
  };

  nix = {
    useSandbox = true;
    buildCores = 0;  # 0 means auto-detect number of CPUs (and use all)

    extraOptions = ''
      # To not get caught by the '''"nix-collect-garbage -d" makes
      # "nixos-rebuild switch" unusable when nixos.org is down"''' issue:
      gc-keep-outputs = true
      # Number of seconds to wait for binary-cache to accept() our connect()
      connect-timeout = 15
    '';

    # Automatic garbage collection
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 14d";
  };

  system.stateVersion = "18.03";
}

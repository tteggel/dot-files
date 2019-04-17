{ config, pkgs, ... }:
  
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
      kernelModules = [ "hv_sock" ];
      kernelPackages = pkgs.linuxPackages_latest;
      initrd.checkJournalingFS = false;
  };

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  networking = {
    hostName = "nixos";
    proxy.default = "http://127.0.0.1:3128";
    proxy.noProxy = "127.0.0.1,localhost,wpad";
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

      pam.services.xrdp-sesman-rdp = {
        text = ''
          auth      include   system-remote-login
          account   include   system-remote-login
          password  include   system-remote-login
          session   include   system-remote-login
        '';
      };

     polkit = {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
              if ((action.id == "org.freedesktop.color-manager.create-device" ||
                   action.id == "org.freedesktop.color-manager.modify-profile" ||
                   action.id == "org.freedesktop.color-manager.delete-device" ||
                   action.id == "org.freedesktop.color-manager.create-profile" ||
                   action.id == "org.freedesktop.color-manager.modify-profile" ||
                   action.id == "org.freedesktop.color-manager.delete-profile") &&
                    subject.isInGroup("users")) {
                  return polkit.Result.YES;
              }
          });
        '';
      }; 
  };

  time.timeZone = "Europe/London";

  nixpkgs.config.packageOverrides = pkgs: rec {
    docker = pkgs.docker-edge;
    smith = pkgs.callPackage ./pkgs/smith {};
  };

  virtualisation.docker = {
    enable = true;
    extraOptions = "--mtu=1290";
  };

  services = {
    printing.enable = true;

    emacs.enable = true;

    xserver = {
      enable = true;
      layout = "gb";
      autorun = false;
      videoDrivers = [ "fbdev" ];
      monitorSection = "DisplaySize 343 285";
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
      windowManager = {
        i3.enable = true;
        default = "i3";
      }; 
    };

    xrdp = {
      enable = true;
      defaultWindowManager = "${config.services.xserver.displayManager.session.wrapper}";
      package = pkgs.xrdp.overrideAttrs (old: rec {
        configureFlags = old.configureFlags ++ [ " --enable-vsock" ];     
        postInstall = old.postInstall + ''
          ${pkgs.gnused}/bin/sed -i -e "s/use_vsock=false/use_vsock=true/g" $out/etc/xrdp/xrdp.ini
          ${pkgs.gnused}/bin/sed -i -e "s/security_layer=negotiate/security_layer=rdp/g" $out/etc/xrdp/xrdp.ini
          ${pkgs.gnused}/bin/sed -i -e "s/crypt_level=high/crypt_level=none/g" $out/etc/xrdp/xrdp.ini
          ${pkgs.gnused}/bin/sed -i -e "s/bitmap_compression=true/bitmap_compression=false/g" $out/etc/xrdp/xrdp.ini
          ${pkgs.gnused}/bin/sed -i -e "s/FuseMountName=thinclient_drives/FuseMountName=shared-drives/g" $out/etc/xrdp/sesman.ini
        '';
      });
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
      extraConfig = "ProxyCommand /run/current-system/sw/bin/corkscrew 127.0.0.1 3128 %h %p";
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

      corkscrew

      yubikey-personalization
      gnupg
      keybase
    ];

    shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    etc."X11/Xwrapper.config" = {
      mode = "0644";
      text = ''
        allowed_users=anybody 
        needs_root_rights=auto
      '';
    };

    etc."X11/XLaunchXRDP" = {
      mode = "0755";
      text = ''
        #!/usr/bin/env sh
        exec ${config.services.xserver.windowManager.i3.package}/bin/i3        
      '';
    };

  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = [ pkgs.nerdfonts ];
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

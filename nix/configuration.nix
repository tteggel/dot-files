{ config, pkgs, options, stdenv, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz;
in
{
  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
      smith = pkgs.callPackage ./pkgs/smith {};
      firebase-tools = pkgs.callPackage ./pkgs/firebase-tools {};
      mocha = pkgs.callPackage ./pkgs/mocha {};
      docker = pkgs.docker-edge;
    };
  };

  imports =
    [
      ./hardware-configuration.nix
      ./machine.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "elevator=noop" ];
#    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      checkJournalingFS = false;
      kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
      luks = {
        yubikeySupport = true;
        devices."luks-root" = {
          yubikey = {
            twoFactor = true;
            slot = 2;
            keyLength = 64;
            saltLength = 16;
            gracePeriod = 60;
            storage = {
              device = "/dev/sda1";
              fsType = "vfat";
              path = "/crypt-storage/default";
            };
          };
        };
      };
    };
  };

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixpkgs-unstable;
  };

  networking = {
    hostName = "thomnixe";
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

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
      desktopManager.xterm.enable = false;
      desktopManager.default = "none";
      windowManager.i3.enable = true;
      windowManager.default = "i3";
      displayManager.sddm.enable = true;
      displayManager.sessionCommands = ''
        xss-lock i3lock &
      '';
      dpi = 138;
#      displayManager.defaultSession = "none+i3";
    };

    udev = {
      extraRules = ''
        SUBSYSTEM=="tty", GROUP="dialout"
      '';
      packages = with pkgs; [
        yubikey-personalization
        libu2f-host
      ];
    };

    pcscd.enable = true;
  };

  programs = {
    zsh.enable = true;
    ssh = {
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
      xss-lock
    ];

    shellInit = ''
      OPENSC_PATH=$(nix-build '<nixpkgs>' --no-build-output --no-out-link -A opensc)
      eval $(ssh-agent -s -P $OPENSC_PATH/lib/opensc-pkcs11.so) > /dev/null 2>&1
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
    mutableUsers = false;
    extraUsers.tteggel = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = ["wheel" "input" "audio" "video" "docker" "dialout"];
      shell = pkgs.zsh;
      hashedPassword = "$6$YiZNkbac0NjU$g/.gjO05NUXdjzj3z102rzA6xwv3nG/NCpKtNOaYul0lJKtKY6GVNRtB./1Z1QqEPHAXzyJn1U5PmbusscW3R0";
    };
    groups = { dialout = {}; };
  };

  security = {
    pam.services.login.yubicoAuth = true;
    pam.services.sddm.yubicoAuth = true;
    pam.services.i3lock.yubicoAuth = true;
    pam.services.xss-lock.yubicoAuth = true;
    pam.yubico = {
      id = "tteggel";
      enable = true;
      control = "required";
    };
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

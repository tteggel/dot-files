{ config, pkgs, options, stdenv, lib, ... }:
let
  stableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz;
in
{
  nixpkgs.config = {
    allowUnfree = true;

    pulseaudio = true;

    packageOverrides = pkgs: rec {

      # Other package trees
      stable = import stableTarball {
        config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
      };
      gitPkgs = import "/home/tteggel/src/github.com/nixos/nixpkgs" {
        config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
      };

      # Local packages
      pbkdf2-sha512 = pkgs.callPackage ./pkgs/pbkdf2-sha512 {};
      smith = pkgs.callPackage ./pkgs/smith {};
      firebase-tools = pkgs.callPackage ./pkgs/firebase-tools {};
      mocha = pkgs.callPackage ./pkgs/mocha {};
      meslo-p10k = pkgs.callPackage ./pkgs/meslo-p10k {};
      artillery = pkgs.callPackage ./pkgs/artillery {};

      # Package selections
      docker = pkgs.docker-edge;
      nodejs = pkgs.nodejs-14_x;

      # Bugs
      # https://github.com/NixOS/nixpkgs/issues/90544
      open-vm-tools = gitPkgs.open-vm-tools;

      # Package overrides

      #ffmpeg-full = pkgs.ffmpeg-full.override ({
      #  nonfreeLicensing = true;
      #  fdkaacExtlib = true;
      #});

      google-cloud-sdk = pkgs.google-cloud-sdk.overrideAttrs ( oldAttrs: rec {
        version = "296.0.1";
        src = pkgs.fetchurl {
          url = "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${version}-linux-x86_64.tar.gz";
          hash = "sha256:27df575571eee39f337fc74384274a92dfc015b4da90dcbf9f79de0d5a9eb3e6";
        };
      });

      linuxPackages_latest = pkgs.linuxPackages_latest.extend (self: super: {
        kernel = super.kernel.override {
          kernelPatches = super.kernel.kernelPatches ++ [
            rec {
              name = "0023-Add-DM_CRYPT_FORCE_INLINE-flag-to-dm-crypt-target";
              patch = pkgs.fetchpatch {
                name = name + ".patch";
                url = "https://raw.githubusercontent.com/cloudflare/linux/master/" + name + ".patch";
                sha256 = "1yiw6xzxnigz3ii9afd2409mfl0qx46lj4c7nqq4186ik87cvi3c";
              };
            }

            rec {
              name = "0024-Add-xtsproxy-Crypto-API-module";
              patch = pkgs.fetchpatch {
                name = name + ".patch";
                url = "https://raw.githubusercontent.com/cloudflare/linux/master/" + name + ".patch";
                sha256 = "0cy8784k6p2z37h4jgzv6il6pfxvx18wbgn95gdz2yd33rz43rc9";
              };
            } 
          ];
        };
      });
    };
  };

  imports = [
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
#    kernelModules = [ "xtsproxy" ];
    initrd = {
      checkJournalingFS = false;
#      kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid"  "xtsproxy" ];
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

  networking = {
    hostName = "thomnixe";
    hosts = {
#      "127.0.0.1" = ["app.dev.bookcreator.com" "read.dev.bookcreator.com"];
#      "35.227.242.123" = ["api.dev.bookcreator.com"];
    };
    firewall = {
      enable = true;
    };
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  time.timeZone = "Europe/London";

  virtualisation = {
    vmware.guest = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = "--mtu=1290";
    };
  };

  hardware.pulseaudio.enable = true;

  services = {
    printing.enable = true;

    emacs.enable = true;

    xserver = {
      enable = true;
      layout = "gb";
      videoDrivers = [ "vmware" ];
      desktopManager = {
        xterm.enable = false;
        wallpaper.mode = "fill"; 
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      #displayManager.sddm.enable = true;
      displayManager.sessionCommands = ''
        xss-lock i3lock &
        flameshot &
      '';
      dpi = 138;
      displayManager.defaultSession = "none+i3";
    };

    udev = {
      extraRules = ''
        SUBSYSTEM=="tty", GROUP="dialout"
        ACTION=="remove", ENV{ID_VENDOR_ID}=="1050", ENV{ID_MODEL_ID}=="0407", RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
      packages = with pkgs; [
        yubikey-personalization
        libu2f-host
      ];
    };

    openvpn = {
      servers.ny = {
        autoStart = false;
        updateResolvConf = true;
        config = "config /home/tteggel/.expressvpn/my_expressvpn_usa_-_new_york_udp.ovpn";
        authUserPass = {
          username = (lib.fileContents /home/tteggel/.expressvpn/username);
          password = (lib.fileContents /home/tteggel/.expressvpn/password);
        };
      };
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
      pavucontrol
      alsaTools

      nix-index
      emacs

      git
      unzip
      termite
      tmux
      zsh
      python

      aspell
      aspellDicts.en

      dmenu
      i3status

      htop

      yubikey-personalization
      keyutils
      pbkdf2-sha512
      opensc
      keybase
      xss-lock

      flameshot
    ];

    shellInit = ''
      OPENSC_PATH=$(nix-build '<nixpkgs>' --no-build-output --no-out-link -A opensc)
      eval $(ssh-agent -s -P $OPENSC_PATH/lib/opensc-pkcs11.so) > /dev/null 2>&1
    '';

  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ 
      nerdfonts
      meslo-p10k
    ];
  };

  fileSystems."/home/tteggel/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:thomnixe";
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
    pam.services.tteggel.u2fAuth = true;
    pam.services.sudo.u2fAuth = true;
    pam.services.i3lock.u2fAuth = true;
    pam.services.sddm.u2fAuth = true;
    pam.u2f = {
      enable = true;
      cue = true;
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

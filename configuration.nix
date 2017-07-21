{ config, pkgs, ... }:
  
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./squid.nix
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
    proxy.default = "http://127.0.0.1:3128";
    proxy.noProxy = "127.0.0.1,localhost,wpad-admin.oraclecorp.com";
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

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

    openconnect
    squid
  ];

  services = {
    vmwareGuest.enable = true;

    printing.enable = true;

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
    extraGroups = ["wheel" "input" "audio" "video"];
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

  systemd.services.vpn = {
    enable = true;
    description = "VPN";
    path = with pkgs; [ stdenv openconnect nettools gawk iproute openresolv curl bash ];
    wantedBy = [ "multi-user.target" ];
    after = [ "networking-online.target" ];
    environment = {
      NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      no_proxy = "127.0.0.1,localhost,wpad-admin.oraclecorp.com";
    };
    script = ''
      sleep 1
      ${builtins.readFile /root/vpn.sh}
    '';
    serviceConfig = {
      Type = "simple";
      PIDFile = "/var/run/openconnect";
      User = "root";
      Restart = "always";
      KillMode = "process";
      TimeoutStopSec = 10;
      KillSignal = "SIGINT";
      SendSIGHUP = false;
    };
  };

  systemd.services.wpad = {
    enable = true;
    description = "Autoconfig local squid proxy";
    path = with pkgs; [stdenv nix bash python3 pythonPackages.requests pythonPackages.lxml];
    after = [ "vpn.service" ];
    environment = {
      NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      no_proxy = "127.0.0.1,localhost,wpad-admin.oraclecorp.com";
    };
    script = ''
      sleep 60
      /home/tteggel/.dotfiles/gen-proxy.py > /home/tteggel/.dotfiles/squid-parents.conf
      systemctl restart squid
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

  system.stateVersion = "17.03";

}

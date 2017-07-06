{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
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
    proxy.default = "http://127.0.0.1:8118";
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

    aspell
    aspellDicts.en

    dmenu
    i3status
    
    htop
  ];

  # services.openssh.enable = true;

  # networking.firewall.enable = false;

  services = {
    privoxy = {
      enable = true;
      extraConfig = ''
        forward / www-proxy.uk.oracle.com:80
      '';
    };

    vmwareGuest.enable = true;

    printing.enable = true;

    emacs.enable = true;
    emacs.defaultEditor = true;

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

  system.stateVersion = "17.03";

}

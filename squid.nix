{ config, ... }:

{
  imports = [ ./pkgs/squid.nix ];
  services.squid = {
    enable = true;
    configText = ''
      # Only allow cachemgr access from localhost
      http_access allow localhost manager
      http_access deny manager

      # We strongly recommend the following be uncommented to protect innocent
      # web applications running on the proxy server who think the only
      # one who can access services on "localhost" is a local user
      http_access deny to_localhost

      # Application logs to syslog, access and store logs have specific files
      cache_log       syslog
      access_log      stdio:/var/log/squid/access.log
      cache_store_log stdio:/var/log/squid/store.log

      # Required by systemd service
      pid_filename    /run/squid.pid

      # Run as user and group squid
      cache_effective_user squid squid

      include /home/tteggel/.dotfiles/squid-parents.conf

      acl CONNECT method CONNECT
      never_direct allow CONNECT

      cache deny all

      acl 10.200.10.1 src 10.200.10.1/24
      http_access allow 10.200.10.1
      http_access allow localhost

      # And finally deny all other access to this proxy
      http_access deny all

      http_port 3128
      visible_hostname nixos

      # Leave coredumps in the first cache dir
      coredump_dir /var/cache/squid

      shutdown_lifetime 0

    '';
  };

  systemd.services.squid = {
    serviceConfig = {
      Restart = "always";
      RestartSec = 10;
    };
    requires = [ "vpn.service" "wpad.service" ];
    after = [ "vpn.service" "wpad.service" ];
    partOf = [ "vpn.service" "wpad.service" ];
    bindsTo = [ "vpn.service" "wpad.service"];
  };
}

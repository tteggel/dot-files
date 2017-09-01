{ config, ... }:

{
  services.squid = {
    enable = true;
    configText = ''
      http_access allow localhost manager
      http_access deny manager

      http_access deny to_localhost

      cache_log       syslog
      access_log      stdio:/var/log/squid/access.log
      cache_store_log stdio:/var/log/squid/store.log

      pid_filename    /run/squid.pid

      cache_effective_user squid squid

      include /home/tteggel/.dotfiles/squid-parents.conf

      acl CONNECT method CONNECT
      never_direct allow CONNECT

      cache deny all

      http_access allow localhost
      acl 10.10.10.10 src 10.10.10.10/24
      http_access allow 10.10.10.10

      http_access deny all

      http_port 3128
      visible_hostname nixos

      coredump_dir /var/cache/squid

      shutdown_lifetime 0

    '';
  };

  systemd.services.squid = {
    serviceConfig = {
      Restart = "always";
      RestartSec = 10;
    };
    requires = [ "wpad.service" ];
    after = [ "wpad.service" ];
    partOf = [ "wpad.service" ];
    bindsTo = [ "wpad.service"];
  };
}

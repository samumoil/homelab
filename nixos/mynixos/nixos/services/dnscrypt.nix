{ ... }: {
  services = {
    dnscrypt-proxy2 = {
      enable = false;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;
      };
    };
  };
}

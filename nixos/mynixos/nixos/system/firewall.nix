{ ... }: {
  networking = {
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [
        20 21 # ftp
        22 # ssh
        80 # http
        443 # https
        3000  # adguard
        8384 22000  # syncthing
      ];
      allowedUDPPorts = [
        22000 21027  # syncthing
      ];
      connectionTrackingModules = [
        "amanda"
        "ftp"
        "h323"
        "irc"
        "netbios_sn"
        "pptp"
        "sane"
        "sip"
        "snmp"
        "tftp"
      ];
    };
  };
}

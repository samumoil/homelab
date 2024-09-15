{ ... }: {
  services = {
    postgresql = {
      enable = true;
      enableTCPIP = true;
      settings = {
        ssl = false;
      };
    };
  };
}

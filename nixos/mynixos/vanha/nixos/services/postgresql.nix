{ ... }: {
  services = {
    postgresql = {
      enable = false;
      enableTCPIP = true;
      settings = {
        ssl = false;
      };
    };
  };
}

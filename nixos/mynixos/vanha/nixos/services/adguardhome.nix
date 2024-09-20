{ ... }: {
  services = {
   adguardhome = {
      enable = false;
      openFirewall = true;
      settings = {
        schema_version = 20;
      };
    };
  };
}

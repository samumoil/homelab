{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "activate-linux" = {
            enable = true;
            source = ./config.cfg;
            target = "./activate/config.cfg";
          };
        };
      };
    };
  };
}

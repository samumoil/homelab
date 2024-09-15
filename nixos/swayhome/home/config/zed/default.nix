{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "zed-settings" = {
            enable = false;
            source = ./settings.json;
            target = "./zed/settings.json";
          };
        };
      };
    };
  };
}

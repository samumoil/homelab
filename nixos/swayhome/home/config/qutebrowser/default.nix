{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "qutebrowser-script" = {
            enable = true;
            source = ./script;
            target = "./qutebrowser/greasemonkey";
          };
        };
      };
    };
  };
}

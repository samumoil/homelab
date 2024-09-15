{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      qt = {
        enable = true;
        platformTheme = {
          name = "gtk3";
        };
      };
    };
  };
}

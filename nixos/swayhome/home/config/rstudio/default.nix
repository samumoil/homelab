{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      home = {
        file = {
          "rprofile" = {
            enable = true;
            target = ".Rprofile";
            text = ''
              library("quarto")
            '';
          };
        };
      };
      xdg = {
        configFile = {
          "rstudio-themes" = {
            enable = true;
            source = ./breeze-dark.rstheme;
            target = "./rstudio/themes/breeze-dark.rstheme";
          };
          "rstudio-prefs" = {
            enable = true;
            source = ./rstudio-prefs.json;
            target = "./rstudio/rstudio-prefs.json";
          };
        };
      };
    };
  };
}

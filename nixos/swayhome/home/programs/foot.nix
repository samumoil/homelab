{ ... }: let
  name = "hervyqa";

  # colors without hastag
  black = "31363B";
  red = "ED1515";
  green = "11D116";
  yellow = "F67400";
  blue = "1D99F3";
  purple = "9B59B6";
  cyan = "1ABC9C";
  white = "EFF0F1";
  bright_black = "7F8C8D";
  bright_red = "C0392B";
  bright_green = "1CDC9A";
  bright_yellow = "FDBC4B";
  bright_blue = "3DAEE9";
  bright_purple = "8E44AD";
  bright_cyan = "16A085";
  bright_white = "FCFCFC";
  background = "31363B";
  foreground = "EFF0F1";

in {
  home-manager = {
    users.${name} = {
      programs = {
        foot = {
          enable = true;
          settings = {
            main = {
              font = "Fira Mono:size=10";
              dpi-aware = "no";
              pad = "15x15 center";
            };
            mouse = {
              hide-when-typing = "yes";
            };
            colors = {
              alpha = 1.0;
              foreground = foreground;
              background = background;
              regular0 = black;
              regular1 = red;
              regular2 = green;
              regular3 = yellow;
              regular4 = blue;
              regular5 = purple;
              regular6 = cyan;
              regular7 = white;
              bright0 = bright_black;
              bright1 = bright_red;
              bright2 = bright_green;
              bright3 = bright_yellow;
              bright4 = bright_blue;
              bright5 = bright_purple;
              bright6 = bright_cyan;
              bright7 = bright_white;
            };
          };
        };
      };
    };
  };
}

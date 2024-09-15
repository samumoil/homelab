{ ... }: let
  name = "hervyqa";

  # colors with quotation marks
  black = "'#31363B'";
  red = "'#ED1515'";
  green = "'#11D116'";
  yellow = "'#F67400'";
  blue = "'#1D99F3'";
  purple = "'#9B59B6'";
  cyan = "'#1ABC9C'";
  white = "'#EFF0F1'";
  bright_black = "'#7F8C8D'";
  bright_red = "'#C0392B'";
  bright_green = "'#1CDC9A'";
  bright_yellow = "'#FDBC4B'";
  bright_blue = "'#3DAEE9'";
  bright_purple = "'#8E44AD'";
  bright_cyan = "'#16A085'";
  bright_white = "'#FCFCFC'";
  background = "'#31363B'";
  foreground = "'#EFF0F1'";
  cursorColor = "'#EFF0F1'";
  selectionBackground = "'#EFF0F1'";

in {
  home-manager = {
    users.${name} = {
      programs = {
        cava = {
          enable = true;
          settings = {
            general = {
              framerate = 24;
              bars = 0;
              bar_width = 1;
              bar_spacing = 1;
            };
            smoothing = {
              noise_reduction = 88;
            };
            color = {
              gradient = 1;
              gradient_count = 3;
              gradient_color_1 = bright_blue;
              gradient_color_2 = bright_cyan;
              gradient_color_3 = bright_yellow;
            };
          };
        };
      };
    };
  };
}

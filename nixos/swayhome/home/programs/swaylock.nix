{ ... }: let
  name = "hervyqa";

  # colors
  black = "#31363B";
  red = "#ED1515";
  green = "#11D116";
  yellow = "#F67400";
  blue = "#1D99F3";
  purple = "#9B59B6";
  cyan = "#1ABC9C";
  white = "#EFF0F1";
  bright_black = "#7F8C8D";
  bright_red = "#C0392B";
  bright_green = "#1CDC9A";
  bright_yellow = "#FDBC4B";
  bright_blue = "#3DAEE9";
  bright_purple = "#8E44AD";
  bright_cyan = "#16A085";
  bright_white = "#FCFCFC";
  background = "#31363B";
  foreground = "#EFF0F1";
  cursorColor = "#EFF0F1";
  selectionBackground = "#EFF0F1";

in {
  home-manager = {
    users.${name} = {
      programs = {
        swaylock = {
          enable = true;
          settings = {
            bs-hl-color = foreground;
            caps-lock-bs-hl-color = foreground;
            caps-lock-key-hl-color = bright_green;
            color = background;
            inside-caps-lock-color = background;
            inside-clear-color = background;
            inside-color = background;
            inside-ver-color = background;
            inside-wrong-color = background;
            key-hl-color = bright_green;
            layout-bg-color = background;
            layout-border-color = background;
            layout-text-color = bright_blue;
            line-caps-lock-color = background;
            line-clear-color = background;
            line-color = background;
            line-ver-color = background;
            line-wrong-color = background;
            ring-caps-lock-color = bright_yellow;
            ring-clear-color = foreground;
            ring-color = bright_cyan;
            ring-ver-color = bright_blue;
            ring-wrong-color = bright_red;
            separator-color = background;
            text-caps-lock-color = bright_purple;
            text-clear-color = bright_blue;
            text-color = foreground;
            text-ver-color = bright_blue;
            text-wrong-color = bright_red;
            font = "Fira Sans";
            font-size = 14;
            disable-caps-lock-text = true;
            ignore-empty-password = true;
            indicator = true;
            indicator-caps-lock = true;
            indicator-radius = 50;
            indicator-thickness = 10;
          };
        };
      };
    };
  };
}

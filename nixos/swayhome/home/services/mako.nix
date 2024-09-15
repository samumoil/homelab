{ ... }: let
  name = "hervyqa";

  # colors
  black = "#31363BFF";
  red = "#ED1515FF";
  green = "#11D116FF";
  yellow = "#F67400FF";
  blue = "#1D99F3FF";
  purple = "#9B59B6FF";
  cyan = "#1ABC9CFF";
  white = "#EFF0F1FF";
  bright_black = "#7F8C8DFF";
  bright_red = "#C0392BFF";
  bright_green = "#1CDC9AFF";
  bright_yellow = "#FDBC4BFF";
  bright_blue = "#3DAEE9FF";
  bright_purple = "#8E44ADFF";
  bright_cyan = "#16A085FF";
  bright_white = "#FCFCFCFF";
  background = "#31363BFF";
  foreground = "#EFF0F1FF";
  cursorColor = "#EFF0F1FF";
  selectionBackground = "#EFF0F1FF";

in {
  home-manager = {
    users.${name} = {
      services = {
        mako = {
          enable = true;
          backgroundColor = background;
          borderColor = bright_blue;
          borderSize = 3;
          defaultTimeout = 5000; # 5s
          font = "Fira Sans 10";
          margin = "30";
          padding = "5";
          progressColor = "over ${bright_cyan}";
          textColor = foreground;
        };
      };
    };
  };
}

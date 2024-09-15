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
        zellij = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            copy_command = "wl-copy";
            default_layout = "compact";
            default_shell = "fish";
            pane_frames = false;
            simplified_ui = true;
            theme = "${name}";
            themes = {
              ${name} = {
                fg = foreground;
                bg = background;
                black = black;
                red = red;
                green = green;
                yellow = yellow;
                blue = blue;
                magenta = purple;
                cyan = cyan;
                white = white;
                orange = yellow;
              };
            };
            plugins = {
              tab-bar.path = "tab-bar";
              status-bar.path = "status-bar";
              strider.path = "strider";
              compact-bar.path = "compact-bar";
            };
            ui = {
              pane_frames = {
                hide_session_name = true;
                rounded_corners = false;
              };
            };
          };
        };
      };
    };
  };
}

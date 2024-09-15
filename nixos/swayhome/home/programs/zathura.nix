{ ... }: let
  name = "hervyqa";

  # colors
  black = "rgba(49, 54, 59, 1.00)";
  red = "rgba(237, 21, 21, 1.00)";
  green = "rgba(17, 209, 22, 1.00)";
  yellow = "rgba(246, 116, 0, 1.00)";
  blue = "rgba(29, 153, 243, 1.00)";
  purple = "rgba(155, 89, 182, 1.00)";
  cyan = "rgba(26, 188, 156, 1.00)";
  white = "rgba(239, 240, 241, 1.00)";
  bright_black = "rgba(127, 140, 141, 1.00)";
  bright_red = "rgba(192, 57, 43, 1.00)";
  bright_green = "rgba(28, 220, 154, 1.00)";
  bright_yellow = "rgba(253, 188, 75, 1.00)";
  bright_blue = "rgba(61, 174, 233, 1.00)";
  bright_purple = "rgba(142, 68, 173, 0.50)";
  bright_cyan = "rgba(22, 160, 133, 0.50)";
  bright_white = "rgba(252, 252, 252, 1.00)";
  background = "rgba(49, 54, 59, 0.90)";
  foreground = "rgba(239, 240, 241, 1.00)";
  cursorColor = "rgba(239, 240, 241, 1.00)";
  selectionBackground = "rgba(239, 240, 241, 1.00)";

in {
  home-manager = {
    users.${name} = {
      programs = {
        zathura = {
          enable = true;
          options = {
            adjust-open = "width";
            font = "Fira Sans 10";
            guioptions = "s";
            pages-per-row = 1;
            recolor = true;
            scroll-step = 50;
            completion-bg = background;
            completion-fg = foreground;
            completion-group-bg = background;
            completion-group-fg = foreground;
            completion-highlight-bg = bright_blue;
            completion-highlight-fg = foreground;
            default-bg = background;
            default-fg = foreground;
            highlight-active-color = bright_purple;
            highlight-color = bright_cyan;
            highlight-fg = foreground;
            index-active-bg = bright_blue;
            index-active-fg = foreground;
            index-bg = background;
            index-fg = foreground;
            inputbar-bg = background;
            inputbar-fg = foreground;
            notification-bg = background;
            notification-error-bg = background;
            notification-error-fg = bright_red;
            notification-fg = foreground;
            notification-warning-bg = background;
            notification-warning-fg = bright_yellow;
            recolor-darkcolor = foreground;
            recolor-lightcolor = background;
            render-loading-bg = background;
            render-loading-fg = foreground;
            scrollbar-bg = bright_black;
            scrollbar-fg = foreground;
            statusbar-bg = background;
            statusbar-fg = foreground;
            selection-clipboard = "clipboard";
            statusbar-home-tilde = true;
            scroll-page-aware = true;
            window-title-basename = true;
          };
        };
      };
    };
  };
}

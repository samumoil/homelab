{
  pkgs,
  ...
}:
with pkgs;
let
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
      config, ... }:
      {
      programs = {
        rofi = {
          enable = true;
          font = "Fira Sans 10";
          package = rofi-wayland;
          extraConfig = {
            case-sensitive = false;
            display-drun = "Apps:";
            modi = [
              "drun"
              "filebrowser"
              "run"
            ];
            show-icons = false;
          };
          pass = {
            enable = true;
            package = rofi-pass-wayland;
            stores = [ "/home/${name}/.pass" ];
          };
          plugins = [
            rofi-file-browser
            rofi-pass-wayland
            rofi-pulse-select
            rofi-systemd
          ];
          theme = let mkLiteral = config.lib.formats.rasi.mkLiteral;
            in {
              "*" = {
                bg = mkLiteral background ;
                fg = mkLiteral foreground;
                ac = mkLiteral bright_blue;
                background-color = mkLiteral "transparent";
              };

              "#window" = {
                background-color = mkLiteral "@bg";
                location = mkLiteral "center";
                width = mkLiteral "30%";
              };

              "#prompt" = {
                text-color = mkLiteral "@fg";
              };

              "#textbox-prompt-colon" = {
                text-color = mkLiteral "@fg";
              };

              "#entry" = {
                text-color = mkLiteral "@fg";
                blink = mkLiteral "true";
              };

              "#inputbar" = {
                children = mkLiteral "[ prompt, entry ]";
                text-color = mkLiteral "@fg";
                padding = mkLiteral "5px";
              };

              "#listview" = {
                columns = mkLiteral "1";
                lines = mkLiteral "6";
                cycle = mkLiteral "true";
                dynamic = mkLiteral "true";
              };

              "#mainbox" = {
                border = mkLiteral "3px";
                border-color = mkLiteral "@ac";
                children = mkLiteral "[ inputbar, listview ]";
                padding = mkLiteral "10px";
              };

              "#element" = {
                text-color = mkLiteral "@fg";
                padding = mkLiteral "5px";
              };

              "#element-icon" = {
                text-color = mkLiteral "@fg";
                size = mkLiteral "32px";
              };

              "#element-text" = {
                text-color = mkLiteral "@fg";
                padding = mkLiteral "5px";
              };

              "#element selected" = {
                border = mkLiteral "3px";
                border-color = mkLiteral "@ac";
                text-color = mkLiteral "@fg";
                background-color = mkLiteral "@ac";
              };
            }
          ;
        };
      };
    };
  };
}

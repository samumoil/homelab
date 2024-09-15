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
        qutebrowser = {
          enable = true;
          searchEngines = {
            DEFAULT = "https://duckduckgo.com/?q={}";
            pr = "https://invidious.privacyredirect.com/search?q={}";
            an = "https://annas-archive.org/search?index=&q={}";
            lg = "https://libgen.rs/search.php?req={}";
            gh = "https://github.com/search?q={}";
            hm = "https://home-manager-options.extranix.com/?query={}";
            nx = "https://search.nixos.org/packages?query={}";
            op = "https://search.nixos.org/options?query={}";
          };
          settings = {
            scrolling = {
              bar = "overlay";
              smooth = true;
            };
            statusbar.show = "always";
            tabs = {
              tabs_are_windows = false;
              show = "always";
            };
            zoom = {
              default = 100;
              levels = [
                "10%" "20%" "30%" "40%" "50%"
                "60%" "70%" "80%" "90%" "100%"
                "110%" "125%" "150%" "175%" "200%"
                "250%" "300%" "400%" "500%" "600"
              ];
            };
            url = {
              auto_search = "naive";
              default_page = "https://start.duckduckgo.com";
              start_pages = ["https://start.duckduckgo.com"];
            };
            colors = {
              contextmenu = {
                menu.bg = background;
                menu.fg = foreground;
                disabled.bg = background;
                disabled.fg = foreground;
                selected.bg = bright_blue;
                selected.fg = foreground;
              };
              completion = {
                category = {
                  bg = background;
                  border.bottom = background;
                  border.top = background;
                  fg = foreground;
                };
                fg = foreground;
                item = {
                  selected = {
                    bg = bright_blue;
                    border = {
                      bottom = bright_blue;
                      top = bright_blue;
                    };
                    fg = foreground;
                    match.fg = foreground;
                  };
                };
                match = {
                  fg = foreground;
                };
                scrollbar = {
                  bg = background;
                  fg = foreground;
                };
                odd = {
                  bg = background;
                };
                even = {
                  bg = background;
                };
              };
              downloads= {
                bar.bg = background;
                error.bg = bright_red;
                error.fg = foreground;
                start.bg = bright_yellow;
                start.fg = foreground;
                stop.bg = bright_green;
                stop.fg = foreground;
                system.bg = "none";
                system.fg = "none";
              };
              hints = {
                bg = bright_blue;
                fg = foreground;
                match.fg = foreground;
              };
              keyhint = {
                bg = background;
                fg = foreground;
                suffix.fg = foreground;
              };
              messages = {
                error.bg = bright_red;
                error.border = background;
                error.fg = foreground;
                info.bg = bright_green;
                info.border = background;
                info.fg = foreground;
                warning.bg = bright_purple;
                warning.border = background;
                warning.fg = foreground;
              };
              prompts = {
                bg = background;
                border = "1px solid " + bright_blue;
                fg = foreground;
                selected.bg = bright_blue;
                selected.fg = foreground;
              };
              statusbar = {
                normal.bg = background;
                insert.bg = bright_green;
                command.bg = background;
                caret.bg = background;
                caret.selection.bg = background;
                progress.bg = background;
                passthrough.bg = bright_purple;
                normal.fg = foreground;
                insert.fg = foreground;
                command.fg = foreground;
                passthrough.fg = foreground;
                caret.fg = foreground;
                caret.selection.fg = foreground;
                url.error.fg = foreground;
                url.fg = foreground;
                url.hover.fg = foreground;
                url.success.http.fg = foreground;
                url.success.https.fg = foreground;
                url.warn.fg = foreground;
                private.bg = bright_cyan;
                private.fg = foreground;
                command.private.bg = background;
                command.private.fg = foreground;
              };
              tabs = {
                bar.bg = background;
                even.bg = background;
                odd.bg = background;
                even.fg = foreground;
                odd.fg = foreground;
                indicator.error = bright_red;
                indicator.system = "none";
                selected.even.bg = bright_black;
                selected.odd.bg = bright_black;
                selected.even.fg = foreground;
                selected.odd.fg = foreground;
              };
              webpage = {
                preferred_color_scheme = "dark";
                darkmode = {
                  enabled = false;
                  policy = {
                    page = "always";
                  };
                };
              };
            };
            content = {
              autoplay = false;
              user_stylesheets = "${./../config/qutebrowser/style.css}";
              notifications = {
                enabled = true;
              };
              blocking.adblock.lists = [
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_8.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_22.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_24.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_39.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_45.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_46.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_48.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_50.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_53.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_55.txt"
              ];
            };
            fonts = {
              completion.entry = "10.0pt Fira Sans";
              debug_console = "10.0pt Fira Sans";
              default_family = [ "Fira Sans" ];
              default_size = "10.0pt";
              downloads = "10.0pt Fira Sans";
              hints = "10.0pt Fira Sans";
              keyhint = "10.0pt Fira Sans";
              messages.error = "10.0pt Fira Sans";
              messages.info = "10.0pt Fira Sans";
              messages.warning = "10.0pt Fira Sans";
              statusbar = "10.0pt Fira Sans";
              web.size.default = 15;
            };
          };
        };
      };
    };
  };
}

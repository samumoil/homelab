{
  lib,
  pkgs,
  ...
}:
with lib;
with pkgs;
let
  name = "hervyqa";
  mod4 = "Mod4";
  output = "eDP-1";
  opacity = "1.0";

  # navigation
  left = "h";
  down = "j";
  up = "k";
  right = "l";

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

  window_bg_color = background;
  view_bg_color = bright_black;
  view_fg_color = foreground;
  accent_bg_color = bright_blue;
  accent_fg_color = foreground;
  urgent_bg_color = bright_red;
  urgent_fg_color = foreground;

  # printscreen
  shot = "${grim}/bin/grim";
  screenrec = "wl-screenrec";
  recorder = "${wl-screenrec}/bin/${screenrec}";
  area = "$(${slurp}/bin/slurp -d)";
  opt = "--low-power=off";
  filename = "$(${coreutils-full}/bin/date +%Y%m%d_%Hh%Mm%Ss_@${name}";
  pfilename = "$(${xdg-user-dirs}/bin/xdg-user-dir PICTURES)/screenshot/${filename}.png)";
  vfilename = "$(${xdg-user-dirs}/bin/xdg-user-dir VIDEOS)/recording/${filename}.mp4)";

in {
  home-manager = {
    users.${name} = {
      wayland = {
        windowManager = {
          sway = {
            enable = true;
            config = {
              modifier = "${mod4}";
              bars = [{
                command = "${waybar}/bin/waybar";
              }];
              focus = {
                forceWrapping = false;
                followMouse = false;
              };
              fonts = {
                names = ["Fira Sans"];
                size = 10.0;
              };
              gaps = {
                inner = 15;
              };
              startup = [
                { command = "${snippetexpanderd}/bin/snippetexpanderd"; }
                { command = "${wpaperd}/bin/wpaperd"; }
                # activate-linux
                # { command = "${activate-linux}/bin/activate-linux -C /home/${name}/.config/activate/config.cfg"; }
                # live wallpaper
                # { command = "${mpvpaper}/bin/mpvpaper -o 'loop' ${output} ${./../../asset/livewall/hd}"; }
              ];
              input = {
                "type:touchpad" = {
                  dwt = "enabled";
                  tap = "enabled";
                  natural_scroll = "enabled";
                  middle_emulation = "enabled";
                };
              };
              workspaceOutputAssign = let
                first = "eDP-1 VGA-1";
                second = "DP-1 DP-2 DP-3 DP-4 HDMI-A-1 HDMI-A-2";
              in [
                { output = first; workspace = "1"; }
                { output = first; workspace = "2"; }
                { output = first; workspace = "3"; }
                { output = first; workspace = "4"; }
                { output = first; workspace = "5"; }
                { output = second; workspace = "6"; }
                { output = second; workspace = "7"; }
                { output = second; workspace = "8"; }
                { output = second; workspace = "9"; }
                { output = second; workspace = "10"; }
              ];
              window = {
                border = 3;
                titlebar = false;
                commands = [
                  {
                    command = "opacity ${opacity}, border pixel 3";
                    criteria = {
                      class = ".*";
                    };
                  }
                  {
                    command = "opacity ${opacity}, border pixel 3";
                    criteria = {
                      app_id = ".*";
                    };
                  }
                  {
                    command = "resize set 650 450";
                    criteria = {
                      app_id = "snippetexpandergui";
                    };
                  }
                  {
                    command = "floating enable, sticky enable";
                    criteria = {
                      title = "Picture-in-Picture";
                    };
                  }
                  {
                    command = "floating enable, sticky enable";
                    criteria = {
                      title = ".*Sharing Indicator.*";
                    };
                  }
                ];
              };
              assigns = {
                "1" = [ # terminal
                  { app_id = "foot"; }
                ];
                "2" = [ # browser
                  { app_id = ".*qutebrowser"; }
                  { app_id = "firefox"; }
                ];
                "3" = [ # entertainment
                  { app_id = ".*telegram.*"; }
                  { app_id = "discord"; }
                ];
                "4" = [ # office
                  { app_id = "texstudio"; }
                  { app_id = "libreoffice-*"; }
                  { class = "Zotero"; }
                ];
                "5" = [ # editor
                  { app_id = "vscode"; }
                  { app_id = ".*zed.*"; }
                  { instance = "vscodium"; }
                ];
                "6" = [ # editor
                  { app_id = ".*biolab.*"; }
                  { app_id = "spyder"; }
                ];
                "7" = [ # datalabs
                  { app_id = "DBeaver"; }
                  { app_id = "rstudio"; }
                  { app_id = "sqlitebrowser"; }
                ];
                "8" = [ # design
                  { app_id = "inkscape"; }
                  { app_id = "scribus"; }
                  { instance = "krita"; }
                  { instance = "gimp"; }
                ];
                "9" = [ # animation
                  { app_id = "blender"; }
                  { app_id = "synfigstudio"; }
                ];
                "10" = [ # multimedia
                  { app_id = "lmms"; }
                  { app_id = ".*kdenlive"; }
                  { app_id = "tenacity"; }
                ];
              };
              floating = {
                modifier = "${mod4}";
                border = 3;
                titlebar = false;
                criteria = [
                  { app_id = ".*themechanger.*"; }
                  { app_id = ".*wl_mirror"; }
                  { app_id = ".*zathura"; }
                  { app_id = "imv"; }
                  { app_id = "inkview"; }
                  { app_id = "kvantummanager"; }
                  { app_id = "mpv"; }
                  { app_id = "qt5ct"; }
                  { app_id = "qt6ct"; }
                  { app_id = "sioyek"; }
                  { app_id = "snippetexpandergui"; }
                  { app_id = "system-config-printer"; }
                  { app_id = "wdisplays"; }
                  { app_id = "xdg-desktop-portal-gtk"; }
                  { class = "Zotero"; }
                  { instance = "lxappearance"; }
                ];
              };
              keybindings = mkOptionDefault {
                # rofi: menu
                "${mod4}+d" = "exec ${rofi}/bin/rofi -show drun";
                # rofi: clipboard manager
                "${mod4}+c" = "exec ${cliphist}/bin/cliphist list | ${rofi}/bin/rofi -dmenu | ${cliphist}/bin/cliphist decode | ${wl-clipboard}/bin/wl-copy";
                # rofi: password store
                "${mod4}+e" = "exec ${rofi-pass-wayland}/bin/rofi-pass";
                # rofi: power menu
                "${mod4}+x" = "exec ${rofi}/bin/rofi -show menu -modi 'menu:${rofi-power-menu}/bin/rofi-power-menu --no-symbols'";
                # rofi: filebrowser
                "${mod4}+g" = "exec ${rofi}/bin/rofi -show filebrowser";
                # rofi: emoji
                "${mod4}+m" = "exec ${bemoji}/bin/bemoji";
                # pick color
                "${mod4}+n" = "exec ${wl-color-picker}/bin/wl-color-picker clipboard";
                # mirror screen
                "${mod4}+o" = "exec ${wl-mirror}/bin/wl-present mirror";

                # modes
                "${mod4}+i" = "mode message";
                "${mod4}+p" = "mode randr";
                "${mod4}+r" = "mode resize";
                "${mod4}+u" = "mode audio";
                "Print" = "mode printscreen";
                "Shift+Print" = "mode recording";

                "${mod4}+period" = "workspace next";
                "${mod4}+comma" = "workspace prev";

                "${mod4}+1" = "workspace number 1";
                "${mod4}+2" = "workspace number 2";
                "${mod4}+3" = "workspace number 3";
                "${mod4}+4" = "workspace number 4";
                "${mod4}+5" = "workspace number 5";
                "${mod4}+6" = "workspace number 6";
                "${mod4}+7" = "workspace number 7";
                "${mod4}+8" = "workspace number 8";
                "${mod4}+9" = "workspace number 9";

                "${mod4}+Shift+period" = "move container to workspace next; workspace next";
                "${mod4}+Shift+comma" = "move container to workspace prev; workspace prev";

                "${mod4}+Shift+1" = "move container to workspace number 1";
                "${mod4}+Shift+2" = "move container to workspace number 2";
                "${mod4}+Shift+3" = "move container to workspace number 3";
                "${mod4}+Shift+4" = "move container to workspace number 4";
                "${mod4}+Shift+5" = "move container to workspace number 5";
                "${mod4}+Shift+6" = "move container to workspace number 6";
                "${mod4}+Shift+7" = "move container to workspace number 7";
                "${mod4}+Shift+8" = "move container to workspace number 8";
                "${mod4}+Shift+9" = "move container to workspace number 9";

                "${mod4}+${left}" = "focus left";
                "${mod4}+${down}" = "focus down";
                "${mod4}+${up}" = "focus up";
                "${mod4}+${right}" = "focus right";

                "${mod4}+Ctrl+${left}" = "move workspace to output left";
                "${mod4}+Ctrl+${down}" = "move workspace to output down";
                "${mod4}+Ctrl+${up}" = "move workspace to output up";
                "${mod4}+Ctrl+${right}" = "move workspace to output right";

                "${mod4}+Shift+${left}" = "move left";
                "${mod4}+Shift+${down}" = "move down";
                "${mod4}+Shift+${up}" = "move up";
                "${mod4}+Shift+${right}" = "move right";

                # audio control
                "XF86AudioRaiseVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
                "XF86AudioLowerVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
                "XF86AudioMute" = "exec ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

                # mic control
                "${mod4}+XF86AudioRaiseVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
                "${mod4}+XF86AudioLowerVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
                "${mod4}+XF86AudioMute" = "exec ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

                # player control
                "XF86AudioPlay" = "exec ${playerctl}/bin/playerctl play-pause --player=%any,mpv,mpd";
                "XF86AudioPrev" = "exec ${playerctl}/bin/playerctl previous --player=%any,mpv,mpd";
                "XF86AudioNext" = "exec ${playerctl}/bin/playerctl next --player=%any,mpv,mpd";
                "XF86AudioStop" = "exec ${playerctl}/bin/playerctl play-pause --player=%any,mpv,mpd";

                # brightness
                "XF86MonBrightnessUp" = "exec ${light}/bin/light -A 2";
                "XF86MonBrightnessDown" = "exec ${light}/bin/light -U 2";
              };
              colors = {
                background = window_bg_color;
                focused = {
                  border = accent_bg_color;
                  background = accent_bg_color;
                  text = accent_fg_color;
                  indicator = accent_bg_color;
                  childBorder = accent_bg_color;
                };
                focusedInactive = {
                  border = view_bg_color;
                  background = view_bg_color;
                  text = view_fg_color;
                  indicator = view_bg_color;
                  childBorder = view_bg_color;
                };
                unfocused = {
                  border = view_bg_color;
                  background = view_bg_color;
                  text = view_fg_color;
                  indicator = view_bg_color;
                  childBorder = view_bg_color;
                };
                urgent = {
                  border = urgent_bg_color;
                  background = urgent_bg_color;
                  text = urgent_fg_color;
                  indicator = urgent_bg_color;
                  childBorder = urgent_bg_color;
                };
                placeholder = {
                  border = accent_bg_color;
                  background = accent_bg_color;
                  text = accent_fg_color;
                  indicator = accent_bg_color;
                  childBorder = accent_bg_color;
                };
              };
              modes = {
                audio = {
                  # audio = "launch: [i]input [o]output";
                  Escape = "mode default";
                  Return = "mode default";
                  "i" = "exec ${rofi-pulse-select}/bin/rofi-pulse-select source, mode default";
                  "o" = "exec ${rofi-pulse-select}/bin/rofi-pulse-select sink, mode default";
                };
                message = {
                  Escape = "mode default";
                  Return = "mode default";
                  "1" = ''exec ${snippetexpander}/bin/snippetexpander copy :1, mode default'';
                  "2" = ''exec ${snippetexpander}/bin/snippetexpander copy :2, mode default'';
                  "3" = ''exec ${snippetexpander}/bin/snippetexpander copy :3, mode default'';
                  "4" = ''exec ${snippetexpander}/bin/snippetexpander copy :4, mode default'';
                  "5" = ''exec ${snippetexpander}/bin/snippetexpander copy :5, mode default'';
                  "6" = ''exec ${snippetexpander}/bin/snippetexpander copy :6, mode default'';
                  "7" = ''exec ${snippetexpander}/bin/snippetexpander copy :7, mode default'';
                  "8" = ''exec ${snippetexpander}/bin/snippetexpander copy :8, mode default'';
                  "9" = ''exec ${snippetexpander}/bin/snippetexpander copy :9, mode default'';
                  "0" = ''exec ${snippetexpandergui}/bin/snippetexpandergui, mode default'';
                };
                printscreen = {
                  # printscreen = "launch: [1]save-area [2]save-fullarea";
                  Escape = "mode default";
                  Return = "mode default";
                  "1" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${shot} -g "${area}" "${pfilename}" | ${wl-clipboard}/bin/wl-copy -t image/png && ${notify-desktop}/bin/notify-desktop "Printscreen" "Screenshot taken...", mode default'';
                  "2" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${shot} "${pfilename}" | ${wl-clipboard}/bin/wl-copy -t image/png && ${notify-desktop}/bin/notify-desktop "Printscreen" "Screenshot taken...", mode default'';
                };
                randr = {
                  Escape = "mode default";
                  Return = "mode default";
                  # 1024x768
                  "1" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform 90, mode default";
                  "2" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform normal, mode default";
                  "3" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform 270, mode default";
                  # 1366x768
                  "4" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform 90, mode default";
                  "5" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform normal, mode default";
                  "6" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform 270, mode default";
                  # 1920x1080
                  "7" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform 90, mode default";
                  "8" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform normal, mode default";
                  "9" = "exec ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform 270, mode default";
                };
                recording = {
                  # recording = "launch:
                  # [1]area-with-audio [2]full-with-audio;
                  # [3]area-without-audio [4]full-without-audio;
                  # [0]stop-record";
                  Escape = "mode default";
                  Return = "mode default";
                  "1" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --geometry "$(${slurp}/bin/slurp -d)" --audio , mode default'';
                  "2" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --audio , mode default'';
                  "3" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --geometry "$(${slurp}/bin/slurp -d)" , mode default'';
                  "4" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" , mode default'';
                  "0" = ''exec ${coreutils-full}/bin/sleep 1.0 && ${procps}/bin/pkill --signal INT ${screenrec} && ${notify-desktop}/bin/notify-desktop "Video record" "Recording stopped...", mode default'';
                };
                resize = {
                  Escape = "mode default";
                  Return = "mode default";
                  "${down}" = "resize grow height 10 px or 10 ppt";
                  "${left}" = "resize shrink width 10 px or 10 ppt";
                  "${right}" = "resize grow width 10 px or 10 ppt";
                  "${up}" = "resize shrink height 10 px or 10 ppt";
                };
                session = {
                  # session = launch:
                  # [h]ibernate [p]oweroff [r]eboot
                  # [s]uspend [l]ockscreen log[o]ut
                  Escape = "mode default";
                  Return = "mode default";
                  "h" = "exec ${systemd}/bin/systemctl hibernate, mode default";
                  "p" = "exec ${systemd}/bin/systemctl poweroff, mode default";
                  "r" = "exec ${systemd}/bin/systemctl reboot, mode default";
                  "s" = "exec ${systemd}/bin/systemctl suspend, mode default";
                  "l" = "exec ${swaylock}/bin/swaylock, mode default";
                  "o" = "exec ${sway}/bin/swaymsg exit, mode default";
                };
              };
            };
          };
        };
      };
    };
  };
}

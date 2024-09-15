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
  bright_purple = "rgba(142, 68, 173, 1.00)";
  bright_cyan = "rgba(22, 160, 133, 1.00)";
  bright_white = "rgba(252, 252, 252, 1.00)";
  background = "rgba(49, 54, 59, 1.00)";
  foreground = "rgba(239, 240, 241, 1.00)";
  cursorColor = "rgba(239, 240, 241, 1.00)";
  selectionBackground = "rgba(239, 240, 241, 1.00)";

in {
  home-manager = {
    users.${name} = {
      programs = {
        waybar = {
          enable = true;
          settings = {
            mainBar = {
              layer = "bottom";
              position = "top";
              height = 24;
              spacing = 0;
              output = [
                "eDP-1"
                "HDMI-A-1"
              ];
              modules-left = [
                "sway/workspaces"
                "sway/mode"
              ];
              modules-center = [
                "clock"
              ];
              modules-right = [
                "network"
                "pulseaudio"
                "backlight"
                "cpu"
                "memory"
                "battery"
                "tray"
              ];
              "keyboard-state" = {
                numlock = true;
                capslock = true;
                format = "{name} {icon}";
                format-icons = {
                  locked = "";
                  unlocked = "";
                };
              };
              "sway/mode" = {
                format = "<span style=\"italic\">{}</span>";
              };
              "sway/workspaces" = {
                on-click = "activate";
                sort-by-number = true;
                format = "{value}";
                format-icons = {
                  "1" = "";
                  "2" = "";
                  "3" = "";
                  "4" = "";
                  "5" = "";
                  "6" = "";
                  "7" = "";
                  "8" = "";
                  "9" = "";
                  "10" = "";
                };
              };
              "sway/scratchpad" = {
                format = "{icon} {count}";
                show-empty = false;
                format-icons = [
                  ""
                  ""
                ];
                tooltip = true;
                tooltip-format = "{app}: {title}";
              };
              "sway/window" = {
                max-length = 30;
              };
              "bluetooth" = {
                format = "{status} ";
                format-disabled = "";
                format-connected = "{num_connections} connected ";
                tooltip-format = "{controller_alias}\t{controller_address}";
                tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
                tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
              };
              "mpd" = {
                format = "{stateIcon} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
                format-disconnected = "Disconnected ";
                format-stopped = "{randomIcon}Stopped ";
                unknown-tag = "N/A";
                interval = 2;
                consume-icons = {
                  "on" = " ";
                };
                random-icons = {
                  off = "<span color=\"#f53c3c\"></span> ";
                  on = " ";
                };
                repeat-icons = {
                  on = "";
                };
                single-icons = {
                  on = " ";
                };
                state-icons = {
                  paused = "";
                  playing = "";
                };
                tooltip-format = "MPD (connected)";
                tooltip-format-disconnected = "MPD (disconnected)";
              };
              "tray" = {
                icon-size = 13;
                spacing = 8;
              };
              "clock" = {
                interval = 60;
                tooltip = false;
                format = "{:%R | %a, %d/%m/%y}";
              };
              "cpu" = {
                format = "{usage}% ";
                tooltip =false;
              };
              "memory" = {
                format = "{}% ";
              };
              "temperature" = {
                # thermal-zone" = 2;
                # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
                critical-threshold = 80;
                # format-critical = "{temperatureC}°C {icon}";
                format = "{temperatureC}°C {icon}";
                format-icons = [
                  ""
                  ""
                  ""
                  ""
                ];
              };
              "backlight" = {
                # device = "acpi_video1";
                format = "{percent}% {icon}";
                format-icons = [
                  "" "" "" "" "" "" "" "" "" "" ""
                ];
              };
              "battery" = {
                states = {
                  good = 97;
                  warning = 30;
                  critical = 10;
                };
                interval = 2;
                format = "{capacity}% {icon}";
                format-charging = "{capacity}% ";
                format-plugged = "{capacity}% ";
                format-alt = "{time} {icon}";
                # "format-good": ""; # An empty format will hide the module
                # "format-full": "";
                format-icons = [
                  ""
                  ""
                  ""
                  ""
                  ""
                ];
              };
              "network" = {
                # "interface" = "wlp2*"; # (Optional) To force the use of this interface
                format-wifi = "{signalStrength}% ";
                format-ethernet = "{ipaddr}/{cidr} ";
                tooltip-format = "{ifname} via {gwaddr} ";
                format-linked = "{ifname} (No IP) ";
                format-disconnected = "Disconnected ";
                format-alt = "{ifname} = {ipaddr}/{cidr} ";
              };
              "pulseaudio" = {
                # "scroll-step" = 1; # %; can be a float
                format = "{volume}% {icon} {format_source}";
                format-bluetooth = "{volume}% {icon} {format_source}";
                format-bluetooth-muted = " {icon} {format_source}";
                format-muted = "{volume}%  {format_source}";
                format-source = "{volume}% ";
                format-source-muted = "{volume}% ";
                format-icons = {
                  headphone = "";
                  hands-free = "";
                  headset = "";
                  phone = "";
                  portable = "";
                  car = "";
                  default = [
                    "" "" ""
                  ];
                };
              };
            };
          };
          style = ''
            * {
              font-family: Fira Sans, FontAwesome;
              font-size: 14px;
            }

            window#waybar {
              color: ${foreground};
              background-color: ${background};
              border-bottom: 3px solid ${bright_blue};
              transition-property: background-color;
              transition-duration: .5s;
            }

            window#waybar.hidden {
              opacity: 0.2;
            }

            /*
            window#waybar.empty {
              background-color: transparent;
            }
            window#waybar.solo {
              background-color: ${bright_blue};
            }
            */

            window#waybar.termite {
              background-color: ${bright_blue};
            }

            window#waybar.chromium {
              background-color: ${bright_blue};
              border: none;
            }

            button {
              box-shadow: inset 0 -3px transparent;
              border: none;
              border-radius: 0;
            }

            button:hover {
              background: inherit;
              box-shadow: inset 0 -3px ${foreground};
            }

            #workspaces button {
              padding: 0 15px;
              background-color: transparent;
            }

            #workspaces button:hover {
              background: rgba(0, 0, 0, 0.2);
            }

            #workspaces button.focused {
              background-color: ${bright_blue};
              box-shadow: inset 0 -3px ${foreground};
            }

            #workspaces button.urgent {
              background-color: ${bright_red};
            }

            #backlight,
            #battery,
            #bluetooth,
            #clock,
            #cpu,
            #disk,
            #memory,
            #mode,
            #mpd,
            #network,
            #pulseaudio,
            #temperature,
            #tray,
            #wireplumber {
              padding: 0 8px;
            }

            #window,
            #workspaces {
              margin: 0 8px;
            }

            .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
            }

            .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
            }

            #backlight {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_yellow};
            }

            #battery {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            #battery.charging, #battery.plugged {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            @keyframes blink {
              to {
                color: ${foreground};
                background-color: transparent;
                border-bottom: 3px solid ${bright_green};
              }
            }

            #battery.critical:not(.charging) {
              color: ${foreground};
              background-color: ${bright_red};
              border-bottom: 3px solid ${bright_green};
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
            }

            #bluetooth {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_yellow};
            }

            #clock {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            label:focus {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_blue};
            }

            #cpu {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_purple};
            }

            #disk {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            #memory {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_yellow};
            }

            #mode {
              color: ${foreground};
              background-color: ${bright_blue};
              border-bottom: 3px solid ${foreground};
            }

            #mpd {
              background-color: transparent;
            }

            #mpd.disconnected {
              background-color: transparent;
            }

            #mpd.stopped {
              background-color: transparent;
            }

            #mpd.paused {
              background-color: transparent;
            }

            #network {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_cyan};
            }

            #network.disconnected {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_cyan};
            }

            #pulseaudio {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            #pulseaudio.muted {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            #temperature {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_green};
            }

            #temperature.critical {
              background-color: transparent;
              border-bottom: 3px solid ${bright_red};
            }

            #tray {
              background-color: transparent;
              border-bottom: 3px solid ${bright_blue};
            }

            #tray > .passive {
              -gtk-icon-effect: dim;
            }

            #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: transparent;
              border-bottom: 3px solid ${bright_blue};
            }

            #wireplumber {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_yellow};
            }

            #wireplumber.muted {
              color: ${foreground};
              background-color: transparent;
              border-bottom: 3px solid ${bright_yellow};
            }
          '';
        };
      };
    };
  };
}

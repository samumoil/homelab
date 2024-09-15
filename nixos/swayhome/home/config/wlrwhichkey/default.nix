{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
  output = "eDP-1";

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

  # Screen
  shot = "${grim}/bin/grim";
  screenrec = "wl-screenrec";
  recorder = "${wl-screenrec}/bin/${screenrec}";
  area = "$(${slurp}/bin/slurp -d)";
  opt = "--low-power=off";
  filename = "$(${coreutils-full}/bin/date +%Y%m%d_%Hh%Mm%Ss_@${name}";
  pfilename = "$(${xdg-user-dirs}/bin/xdg-user-dir PICTURES)/${filename}.png)";
  vfilename = "$(${xdg-user-dirs}/bin/xdg-user-dir VIDEOS)/${filename}.mp4)";

in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "wlrwhichkey" = {
            enable = false;
            target = "./wlr-which-key/config.yaml";
            text = ''
              font: Fira Sans 12
              background: "${background}"
              color: "${foreground}"
              border: "${bright_blue}"
              separator: " ➜ "
              border_width: 3
              corner_r: 0
              padding: 20

              anchor: center
              margin_right: 0
              margin_bottom: 0
              margin_left: 0
              margin_top: 0

              menu: 
                "m":
                  desc: Message
                  submenu:
                    "1": { desc: Salam Opening, cmd: ${snippetexpander}/bin/snippetexpander copy :1 }
                    "2": { desc: Salam Closing, cmd: ${snippetexpander}/bin/snippetexpander copy :2 }
                    "0": { desc: Edit Snippet, cmd: ${snippetexpandergui}/bin/snippetexpandergui }
                "a":
                  desc: Audio
                  submenu:
                    "1": {desc: Audio Input, cmd: ${rofi-pulse-select}/bin/rofi-pulse-select source }
                    "2": {desc: Audio Output, cmd: ${rofi-pulse-select}/bin/rofi-pulse-select sink }
                "d":
                  desc: Display
                  submenu:
                    "1": { desc: Set 1024x768 Left, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform 90 }
                    "2": { desc: Set 1024x768 Normal, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform normal }
                    "3": { desc: Set 1024x768 Right, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1024x768 --transform 270 }
                    "4": { desc: Set 1366x768 Left, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform 90 }
                    "5": { desc: Set 1366x768 Normal, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform normal }
                    "6": { desc: Set 1366x768 Right, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1366x768 --transform 270 }
                    "7": { desc: Set 1920x1080 Left, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform 90 }
                    "8": { desc: Set 1920x1080 Normal, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform normal }
                    "9": { desc: Set 1920x1080 Right, cmd: ${wlr-randr}/bin/wlr-randr --output ${output} --mode 1920x1080 --transform 270 }
                "p":
                  desc: Printscreen
                  submenu:
                    "1": { desc: Area, cmd: ${coreutils-full}/bin/sleep 1.0 && ${shot} -g "${area}" "${pfilename}" | ${wl-clipboard}/bin/wl-copy -t image/png && ${notify-desktop}/bin/notify-desktop "Printscreen" "Screenshot taken..." }
                    "2": { desc: Fullscreen, cmd: ${coreutils-full}/bin/sleep 1.0 && ${shot} "${pfilename}" | ${wl-clipboard}/bin/wl-copy -t image/png && ${notify-desktop}/bin/notify-desktop "Printscreen" "Screenshot taken..." }
                "r":
                  desc: Recording
                  submenu:
                    "1": { desc: Area with Audio, cmd: ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --geometry "$(${slurp}/bin/slurp -d)" --audio }
                    "2": { desc: Fullscreen with Audio, cmd: ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --audio }
                    "3": { desc: Area without Audio, cmd: ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" --geometry "$(${slurp}/bin/slurp -d)" }
                    "4": { desc: Fullscreen without Audio, cmd: ${coreutils-full}/bin/sleep 1.0 && ${recorder} ${opt} --filename="${vfilename}" }
                    "0": { desc: Stop Recording, cmd: ${coreutils-full}/bin/sleep 1.0 && ${procps}/bin/pkill --signal INT ${screenrec} && ${notify-desktop}/bin/notify-desktop "Video record" "Recording stopped..." }
                "s":
                  desc: Session
                  submenu:
                    "1": { desc: Hibernation, cmd: ${systemd}/bin/systemctl hibernate }
                    "2": { desc: Lockscreen, cmd: ${swaylock}/bin/swaylock }
                    "3": { desc: Logout, cmd: ${sway}/bin/swaymsg exit }
                    "4": { desc: Poweroff, cmd: ${systemd}/bin/systemctl poweroff }
                    "5": { desc: Reboot, cmd: ${systemd}/bin/systemctl reboot }
                    "6": { desc: Suspend, cmd: ${systemd}/bin/systemctl suspend }
            '';
          };
        };
      };
    };
  };
}

{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        mpv = {
          enable = true;
          scripts = with mpvScripts; [
            mpris
            mpv-cheatsheet
          ];
          config = {
            force-window = "yes";
            fullscreen = "no";
            osc = "yes";
            profile = "gpu-hq";
            ytdl-format = "bestvideo+bestaudio";
          };
        };
      };
    };
  };
}

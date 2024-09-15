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
        obs-studio = {
          enable = false;
          plugins = with obs-studio-plugins; [
            wlrobs
            obs-pipewire-audio-capture
          ];
        };
      };
    };
  };
}

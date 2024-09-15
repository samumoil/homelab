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
      home = {
        packages = [
          swaykbdd # per-window keyboard layout for sway
          wayland-utils # wayland utilities (wayland-info)
          wl-clip-persist # keep wayland clipboard even after programs close
          wl-clipboard # command-line copy/paste utilities
          wlprop # xprop clone for wlroots based compositors
          wvkbd # on-screen keyboard for wlroots
        ];
      };
    };
  };
}

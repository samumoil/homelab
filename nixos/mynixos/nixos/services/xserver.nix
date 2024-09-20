{
  pkgs,
  ...
}:
with pkgs;
let
  layout = "fi";
  variant = "nodeadkeys";
in {
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm = {
          enable = false;
        };
      };
      displayManager = {
        lightdm = {
          enable = false;
          greeter = {
            enable = false;
          };
        };
      };
      excludePackages = [
        xterm
      ];
      # default settings
      videoDrivers = [
        "amdgpu"
        "radeon"
        "nouveau"
        "modesetting"
        "fbdev"
      ];
      xkb = {
        layout = "${layout}";
        variant = "${variant}";
      };
    };
  };
}

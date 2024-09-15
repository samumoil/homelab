{
  pkgs,
  ...
}:
with pkgs;
let
  layout = "us";
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
      };
    };
  };
}

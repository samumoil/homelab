{ config, pkgs, ... }:

{
  imports =
    [ # paths of other modules
    ];

  options = {
    # option declarations
  };

  config = {
    services.displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "sam";
    };

    services.desktopManager.plasma6.enable = true;
    environment.systemPackages = with pkgs; [
      foot
      fuzzel
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      font-awesome
      geist-font
    ];
  };
}

{ config, pkgs, ... }:

{
  imports =
    [ # paths of other modules
    ];

  options = {
    # option declarations
  };

  config = {

#    services.displayManager = {
#      sddm.enable = true;
#      sddm.wayland.enable = true;
#      autoLogin.enable = true;
#      autoLogin.user = "sam";
#    };

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
#    services.gnome.gnome-keyring.enable = true;

    # Thunar thumbnail support for images
    services.tumbler.enable = true;

    # enable sway window manager
    programs = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraSessionCommands = ""; # Shell commands executed just before Sway is started.
        extraPackages = with pkgs; [
          grim # screenshot functionality
          wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
          mako # notification system developed by swaywm maintainer
          swaylock
          swayidle
          foot
          fuzzel
          light
          libnotify
          ffmpegthumbnailer
          poppler # Thunar pdf thumbnail render
          kdePackages.ghostwriter
          kdePackages.okular
          haruna      # Videoplayer
        ];
      };
      thunar.enable = true;
      thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      waybar.enable = true;
      nm-applet.enable = true;
      gnome-disks.enable = true;
      file-roller.enable = true;
    };
  
    # Fonts for waybar config
#    fonts.packages = with pkgs; [
#      noto-fonts
#      font-awesome
#      ];
  
    # Let keybindings use "light" without sudo and user use reboot and poweroff without sudo
    security.sudo.extraRules = [{
      groups = [ "wheel" ];
      commands = [
        {
          #command = "${pkgs.light}/bin/light";
          command = "/run/current-system/sw/bin/light";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/poweroff";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/bluetooth";
          options = [ "NOPASSWD" ];
        }
      ];
    }];

  };
}


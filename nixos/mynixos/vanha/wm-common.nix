{ config, pkgs, ... }:

{
  imports =
    [ # paths of other modules
    ];

  options = {
    # option declarations
  };

  config = {
#    # Configure keymap in X11
#    services.xserver = {
#      xkb.layout = "fi";
#      xkb.variant = "nodeadkeys";
#      enable = true;
#    };

#    services.pipewire = {
#      enable = true;
#      alsa.enable = false;
#      alsa.support32Bit = false;
#      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
#    };
    # rtkit is optional but recommended
#    security.rtkit.enable = true;

#    virtualisation.libvirtd.enable = true;
#    programs.virt-manager.enable = true;

    programs = {
      _1password-gui.enable = true;
    };

    environment.systemPackages = with pkgs; [
      geany
      libreoffice
      discord
      OSCAR
      gimp
      CuboCore.coreshot                    
      CuboCore.coreimage
      CuboCore.corearchiver                       
      zoom-us
      whatsapp-for-linux
      jetbrains.idea-community
      transmission
      virtio-win # Virt-manager windows guest compatibility
      #pcloud
    ];


  };
}


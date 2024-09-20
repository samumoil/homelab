# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
      ./nixos


####### https://github.com/NixOS/nixos-hardware/tree/master
#       <nixos-hardware/lenovo/thinkpad/t495>

      # Include window manager configuration.
      ./wm-common.nix
      #./wm-sway.nix
      ./wm-kde_plasma.nix
      ./test.nix
    ];


#  # Configure keymap in X11
#  services.xserver = {
#    xkb.layout = "fi";
#    xkb.variant = "nodeadkeys";
#    enable = true;
#  };

  # Configure console
  console = {
    earlySetup = true;
    keyMap = "fi";
    packages = with pkgs; [ 
      tamsyn 
    ];
    font = "Tamsyn10x20r";
  };

  # Create /samu/
  systemd.tmpfiles.rules = [ 
    "d /samu	 		0700 1000 root" 
    "d /samu/pcloud 		0700 1000 root" 
    "d /samu/credentials 	0700 1000 root"
    "L /home/sam/samu		0700 1000 100 - /samu"
    "L /home/sam/pcloud		0700 1000 100 - /samu/pcloud"
  ];

  programs.zsh.enable = true;

  services = {
    tailscale.enable = true;
#    tailscale.authKeyFile = "/samu/credentials/tailscale.auth";
    gvfs.enable = true; # Mount, trash, and other functionalities
    flatpak.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };


  programs = {
    git.enable = true;
    screen.enable = true;
    yazi.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pciutils
    busybox
    wget
    tree
    btop
    dust
    distrobox
    bat # pretty 'cat' replacement
    #bat-extras.*
  ];
}


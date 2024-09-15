# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };


  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fi";
    xkb.variant = "nodeadkeys";
    enable = true;
  };

  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "sam";
  };

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

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
      ];
      };
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    waybar.enable = true;
  };
 
  xdg.portal.wlr.enable = true; # Sway screen sharing
 
  # Fonts for waybar config
  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    geist-font
    ];

  # Configure console keymap
  console.keyMap = "fi";

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.sam = {
    isNormalUser = true;
    description = "sam";
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  # Create /samu/
  systemd.tmpfiles.rules = [ 
    "d /samu	 		0700 1000 root" 
    "d /samu/pcloud 		0700 1000 root" 
    "d /samu/credentials 	0700 1000 root"
    "L /home/sam/samu		0700 1000 100 - /samu"
    "L /home/sam/pcloud		0700 1000 100 - /samu/pcloud"
  ];

  users.users.toot = {
    isNormalUser = true;
    description = "toot";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };


  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true; # This causes frequent compiling!
  #};
  
  # Virt-manager instead of virtualbox
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services = {
    tailscale.enable = true;
#    tailscale.authKeyFile = "/samu/credentials/tailscale.auth";
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thunar thumbnail support for images
    flatpak.enable = true;
  };

  programs = {
#    firefox.enable = true;
    git.enable = true;
    _1password-gui.enable = true;
    gnome-disks.enable = true;
    screen.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
#    librewolf
    tree
    btop
    geany
    libreoffice
#    chromium
    discord
    OSCAR
    freetube
    gimp
    epiphany
    kdePackages.ghostwriter
    haruna	# Videoplayer
    kdePackages.okular
    CuboCore.coreshot                    
    CuboCore.coreimage
    CuboCore.corearchiver                       
    zoom-us
    ffmpegthumbnailer
    poppler	# Thunar pdf thumbnail render
    whatsapp-for-linux
#    jetbrains.idea-community
#    microsoft-edge
    distrobox
    transmission
    virtio-win # Virt-manager windows guest compatibility
    #bat # pretty 'cat' replacement
    #bat-extras.*
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}


# Minimal and Useful NixOS Configuration for a Proxmox VM

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-server"; # Define your hostname.
  # The global useDHCP flag is deprecated, therefore individually set all interfaces to use DHCP.
  networking.useDHCP = false;
  networking.interfaces.ens18.useDHCP = true; # Replace 'ens18' with your network interface if it's different.

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Set your locale.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.sam = {
    isNormalUser = true;
    description = "Sam";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    nix-tree
    qemu-guest-agent
  ];
  
  # Enable the qemu-guest-agent service
  services.qemuGuest.enable = true;


  # Some programs need SUID wrappers, can be configured here.
  # security.wrappers.ping = pkgs.writeShellScriptBin "ping" ''
  #  exec ${pkgs.iputils}/bin/ping -c 4 "$@"
  # '';

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid password authentication and only allow key-based authentication
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ]; # For SSH
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # Enable docker
  virtualisation.docker.enable = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

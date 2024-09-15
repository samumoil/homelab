{ ... }: let
  ver = "24.11";
in {
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./documentation.nix
    ./environment.nix
    ./firewall.nix
    ./fonts.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./power.nix
    ./security.nix
    ./sound.nix
    ./systemd.nix
    ./timezone.nix
    ./upgrade.nix
    ./users.nix
    ./xdg.nix
    ./zram.nix
  ];
  system = {
    stateVersion = "${ver}";
  };
}

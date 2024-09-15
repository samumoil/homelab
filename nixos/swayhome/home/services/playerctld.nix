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
      services = {
        playerctld = {
          enable = true;
          package = playerctl;
        };
      };
    };
  };
}

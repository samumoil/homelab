{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  services = {
    displayManager = {
      enable = true;
      sessionPackages = [ sway ];
      autoLogin = {
        enable = true;
        user = "${name}";
      };
    };
  };
}

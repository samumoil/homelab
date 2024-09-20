{
  pkgs,
  ...
}:
with pkgs;
let
  name = "sam";
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

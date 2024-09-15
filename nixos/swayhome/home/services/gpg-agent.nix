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
        gpg-agent = {
          enable = true;
          enableFishIntegration = true;
          enableSshSupport = true;
          pinentryPackage = pinentry-gnome3;
        };
      };
    };
  };
}

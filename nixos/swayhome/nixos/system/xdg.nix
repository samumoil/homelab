{
  pkgs,
  ...
}:
with pkgs;
{
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = false;
      };
      configPackages = [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      extraPortals = [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}

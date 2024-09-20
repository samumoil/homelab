{
  pkgs,
  ...
}:
with pkgs;
{
  services = {
    dbus = {
      packages = [
        gcr
      ];
    };
  };
}

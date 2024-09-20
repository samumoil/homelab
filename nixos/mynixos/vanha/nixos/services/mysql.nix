{
  pkgs,
  ...
}:
with pkgs;
{
  services = {
    mysql = {
      enable = false;
      package = mariadb;
    };
  };
}

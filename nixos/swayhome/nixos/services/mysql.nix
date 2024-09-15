{
  pkgs,
  ...
}:
with pkgs;
{
  services = {
    mysql = {
      enable = true;
      package = mariadb;
    };
  };
}

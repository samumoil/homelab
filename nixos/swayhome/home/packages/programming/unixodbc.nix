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
      home = {
        packages = with unixODBCDrivers; [
          psql
          sqlite
        ];
      };
    };
  };
}
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
        packages = [
          luaformatter
          luajit
          z-lua
        ];
      };
    };
  };
}
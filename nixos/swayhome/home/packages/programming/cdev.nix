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
          clang
          gnumake

          ## optional:
          # clazy
          # cppcheck
          # gdb
        ];
      };
    };
  };
}

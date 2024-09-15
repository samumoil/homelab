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
        packages = with libsForQt5.qt5; [
          qtwayland
        ];
      };
    };
  };
}

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
        packages = with qt6Packages; [
          qtwayland
        ];
      };
    };
  };
}

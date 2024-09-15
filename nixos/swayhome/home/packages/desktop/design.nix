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
          blender
          gimp
          inkscape
          krita
        ];
      };
    };
  };
}

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
          hut # cli tool for sourcehut
          netlify-cli # cli tool for netlify
        ];
      };
    };
  };
}

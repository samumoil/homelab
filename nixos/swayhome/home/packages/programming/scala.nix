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
          scala
          scala-cli
          scalafmt

          ## optional:
          # ammonite
          # sbt
        ];
      };
    };
  };
}

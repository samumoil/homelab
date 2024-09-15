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
          hugo
          quarto
          sqlpage

          ## optional:
          # gnuplot
          # iredis
          # litecli
          # luigi
          # mpi
        ];
      };
    };
  };
}

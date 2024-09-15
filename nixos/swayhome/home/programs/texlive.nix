{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        texlive = {
          enable = true;
            extraPackages = tpkgs: {
            inherit (tpkgs)
              scheme-medium
              algorithms
              latexmk
            ;
          };
        };
      };
    };
  };
}

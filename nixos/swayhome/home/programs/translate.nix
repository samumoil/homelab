{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        translate-shell = {
          enable = true;
          settings = {
            verbose = true;
          };
        };
      };
    };
  };
}

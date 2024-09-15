{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        lf = {
          enable = false;
          settings = {
          };
        };
      };
    };
  };
}


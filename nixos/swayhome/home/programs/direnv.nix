{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        direnv = {
          enable = true;
        };
      };
    };
  };
}

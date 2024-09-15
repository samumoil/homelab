{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        broot = {
          enable = false;
        };
      };
    };
  };
}

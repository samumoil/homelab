{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        lazygit = {
          enable = false;
        };
      };
    };
  };
}

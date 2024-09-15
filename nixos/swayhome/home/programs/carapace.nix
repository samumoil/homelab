{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        carapace = {
          enable = false;
        };
      };
    };
  };
}

{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        java = {
          enable = true;
        };
      };
    };
  };
}

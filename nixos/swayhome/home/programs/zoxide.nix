{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        zoxide = {
          enable = true;
        };
      };
    };
  };
}

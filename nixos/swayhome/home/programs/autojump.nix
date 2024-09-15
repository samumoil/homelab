{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        autojump = {
          enable = false;
        };
      };
    };
  };
}

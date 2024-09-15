{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        pyenv = {
          enable = true;
        };
      };
    };
  };
}

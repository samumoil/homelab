{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        syncthing = {
          enable = false;
        };
      };
    };
  };
}

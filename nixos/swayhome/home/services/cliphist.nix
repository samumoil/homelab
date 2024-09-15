{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        cliphist = {
          enable = true;
        };
      };
    };
  };
}

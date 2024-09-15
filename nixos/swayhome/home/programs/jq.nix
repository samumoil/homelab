{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        jq = {
          enable = true;
        };
      };
    };
  };
}

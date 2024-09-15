{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        mpd-mpris = {
          enable = true;
        };
      };
    };
  };
}

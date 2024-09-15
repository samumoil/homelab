{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        gh = {
          enable = false;
          settings = {
            editor = "hx";
            git_protocol = "ssh";
          };
        };
      };
    };
  };
}

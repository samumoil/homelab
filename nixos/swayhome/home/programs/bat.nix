{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        bat = {
          enable = true;
          config = {
            italic-text = "always";
            paging = "always";
            tabs = "2";
          };
        };
      };
    };
  };
}

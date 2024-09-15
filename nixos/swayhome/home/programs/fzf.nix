{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        fzf = {
          enable = true;
          enableFishIntegration = true;
        };
      };
    };
  };
}

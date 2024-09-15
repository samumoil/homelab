{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        nix-index = {
          enable = false;
          enableFishIntegration = true;
        };
      };
    };
  };
}

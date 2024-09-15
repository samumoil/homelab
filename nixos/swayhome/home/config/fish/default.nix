{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "fish-prompt" = {
            enable = true;
            source = ./fish_prompt.fish;
            target = "./fish/functions/fish_prompt.fish";
          };
        };
      };
    };
  };
}

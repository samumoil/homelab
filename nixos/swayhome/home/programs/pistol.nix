{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        pistol = {
          enable = false;
          associations = [
            {
              mime = "application/json";
              command = "bat %pistol-filename%";
            }
            {
              mime = "application/*";
              command = "hexyl %pistol-filename%";
            }
            {
              fpath = ".*.md$";
              command = "sh: bat --paging=never --color=always %pistol-filename% | head -8";
            }
          ];
        };
      };
    };
  };
}

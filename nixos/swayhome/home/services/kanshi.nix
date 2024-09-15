{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        kanshi = {
          enable = true;
          settings = [
            { profile.name = "undocked";
              profile.outputs = [
                {
                  adaptiveSync = true;
                  criteria = "eDP-1";
                  mode = "normal";
                  scale = 1.0;
                  status = "enable";
                  transform = "normal";
                }
              ];
            }
            { profile.name = "docked";
              profile.outputs = [
                {
                  adaptiveSync = true;
                  criteria = "eDP-1";
                  mode = "normal";
                  scale = 1.0;
                  status = "enable";
                  transform = "normal";
                }
              ];
            }
          ];
        };
      };
    };
  };
}

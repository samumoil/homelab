{ ...
}: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        swayidle = {
          enable = true;
          events = [
            { event = "before-sleep"; command = "swaylock"; }
            { event = "lock"; command = "swaylock"; }
          ];
          timeouts = [
            { timeout = 300; command = "swaylock -fF"; }
          ];
        };
      };
    };
  };
}

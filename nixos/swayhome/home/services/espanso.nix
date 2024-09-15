{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        espanso = {
          enable = false;
          package = espanso-wayland;
          configs = {
            default = {
              show_notifications = false;
            };
            vscode = {
              filter_title = "Visual Studio Code$";
              backend = "Clipboard";
            };
          };
          matches = {
            base = {
              matches = [
                {
                  trigger = ":now";
                  replace = "It's {{currentdate}} {{currenttime}}";
                }
                {
                  trigger = ":hello";
                  replace = "line1\nline2";
                }
                {
                  regex = ":hi(?P.*)\\.";
                  replace = "Hai, {{person}}!";
                }
              ];
            };
            global_vars = {
              global_vars = [
                {
                  name = "currentdate";
                  type = "date";
                  params = {format = "%d/%m/%Y";};
                }
                {
                  name = "currenttime";
                  type = "date";
                  params = {format = "%R";};
                }
              ];
            };
          };
        };
      };
    };
  };
}

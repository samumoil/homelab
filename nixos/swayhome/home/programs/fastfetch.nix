{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        fastfetch = {
          enable = true;
          settings = {
            logo = {
              type = "none";
              padding = {
                right = 1;
                top = 2;
              };
            };
            display = {
              binaryPrefix = "si";
              color = "blue";
              separator = "  ";
            };
            modules = [
              "title"
              "separator"
              {
                type = "os";
                key = "SYSTEM";
                keyColor = "yellow";
                format = "{2}";
              }
              {
                type = "os";
                key = "├ ";
                keyColor = "yellow";
                format = "{6}{?6} {?}{10}{?10} {?}{8}{?8} {?}{11}";
              }
              {
                type = "kernel";
                key = "├ ";
                keyColor = "yellow";
              }
              {
                type = "packages";
                key = "├ ";
                keyColor = "yellow";
              }
              {
                type = "shell";
                key = "└ ";
                keyColor = "yellow";
              }
              "break"
              {
                type = "wm";
                key = "DESKTOP";
                keyColor = "blue";
              }
              {
                type = "lm";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "theme";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "icons";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "font";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "cursor";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "terminal";
                key = "├ ";
                keyColor = "blue";
              }
              {
                type = "version";
                key = "└ ";
                keyColor = "blue";
              }
              "break"
              {
                type = "host";
                key = "HARDWARE";
                keyColor = "green";
              }
              {
                type = "cpu";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "gpu";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "disk";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "memory";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "uptime";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "display";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "locale";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "vulkan";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "opengl";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "opencl";
                key = "├ ";
                keyColor = "green";
              }
              {
                type = "sound";
                key = "└ ";
                keyColor = "green";
              }
              "break"
            ];
          };
        };
      };
    };
  };
}

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
      gtk = {
        enable = true;
        font = {
          name = "Fira Sans";
          package = fira;
          size= 10;
        };
        theme = {
          name = "Breeze-Dark"; # or Adwaita-dark
          package = libsForQt5.breeze-gtk; # gnome.gnome-themes-extra
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = papirus-icon-theme;
        };
        cursorTheme = {
          name = "breeze_cursors"; # or Adwaita
          size = 24;
        };
        gtk3 = {
          extraCss = ''
          .titlebar,
          .titlebar .background
          {
            border-radius: 0;
          }

          decoration
          {
            box-shadow: none;
          }

          decoration:backdrop
          {
            box-shadow: none;
          }
          '';
        };
      };
    };
  };
}

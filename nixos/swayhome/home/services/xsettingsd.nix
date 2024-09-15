{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        xsettingsd = {
          enable = true;
          settings = {
            "Gdk/WindowScalingFactor" = 1;
            "Gtk/ButtonImages" = 0;
            "Gtk/CursorThemeName" = "breeze_cursors";
            "Gtk/CursorThemeSize" = 24;
            "Gtk/DecorationLayout" = "icon:minimize,maximize,close";
            "Gtk/EnableAnimations" = 1;
            "Gtk/FontName" = "Fira Sans 10";
            "Gtk/MenuImages" = 0;
            "Gtk/OverlayScrolling" = 1;
            "Gtk/PrimaryButtonWarpsSlider" = 0;
            "Gtk/ToolbarStyle" = 3;
            "Net/IconThemeName" = "Papirus-Dark";
            "Net/ThemeName" = "Breeze-Dark";
            "Xft/Antialias" = 1;
            "Xft/DPI" = 98304;
            "Xft/HintStyle" = "hintslight";
            "Xft/Hinting" = 1;
            "Xft/RGBA" = "none";
          };
        };
      };
    };
  };
}

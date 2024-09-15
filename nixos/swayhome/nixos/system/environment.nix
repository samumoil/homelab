{
  pkgs,
  ...
}:
with pkgs;
{
  security.polkit.enable = true;
  environment = {
    etc = {
      "greetd/environments".text = ''
        sway
        fish
        bash
      '';
    };
    unixODBCDrivers = with unixODBCDrivers; [
      mariadb
      psql
      sqlite
    ];
    sessionVariables = {
      # session.
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";

      # wayland stuff.
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      QT_QPA_PLATFORM="wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
      SDL_VIDEODRIVER = "wayland";
    };
  };
}

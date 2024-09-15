{ ... }: let
  name = "hervyqa";
  res = "hd";  # hd/fhd
  wallpaper = "${./../../asset/wallpaper/${res}}";
in {
  home-manager = {
    users.${name} = {
      programs = {
        wpaperd = {
          enable = true;
          settings = {
            default = {
              duration = "2m";
              path = "${wallpaper}";
              sorting = "ascending";
              apply-shadow = false;
            };
          };
        };
      };
    };
  };
}

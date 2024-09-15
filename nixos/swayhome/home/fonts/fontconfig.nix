{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      fonts = {
        fontconfig = {
          enable = true;
        };
      };
    };
  };
}

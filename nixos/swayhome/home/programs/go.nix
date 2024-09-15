{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        go = {
          enable = true;
          goPath = ".go";
          goBin = ".go/bin";
        };
      };
    };
  };
}

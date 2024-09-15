{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        sqls = {
          enable = true;
          settings = {
            lowercaseKeywords = true;
            connections = [ ];
          };
        };
      };
    };
  };
}

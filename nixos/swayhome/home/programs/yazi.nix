{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        yazi = {
          enable = true;
          settings = {
            log = {
              enabled = false;
            };
            manager = {
              ratio = [1 5 2];
              show_hidden = false;
              sort_by = "alphabetical";
              linemode = "size";
              sort_dir_first = true;
              sort_reverse = false;
            };
          };
          theme = {
            icon = {
              rules = [];
            };
            status = {
              separator_open  = "";
              separator_close = "";
            };
          };
        };
      };
    };
  };
}

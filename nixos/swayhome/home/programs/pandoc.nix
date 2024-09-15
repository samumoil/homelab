{ ... }: let
  name = "hervyqa";
  fullname = "Hervy Qurrotul Ainur Rozi";
in {
  home-manager = {
    users.${name} = {
      programs = {
        pandoc = {
          enable = true;
          defaults = {
            metadata = {
              author = "${fullname}";
            };
            pdf-engine = "xelatex";
            citeproc = true;
          };
        };
      };
    };
  };
}

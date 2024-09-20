{ ...
}: let
  name = "sam";
in {
  services = {
   greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "sway";
          user = "${name}";
        };
        default_session = initial_session;
      };
    };
  };
}

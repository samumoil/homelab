{ ... }: let
  name = "sam";
in {
  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        swaylock = {};
      };
    };
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["${name}"];
          groups = ["wheel"];
          keepEnv = true;
          noPass = false;
        }
      ];
      wheelNeedsPassword = true;
    };
  };
}

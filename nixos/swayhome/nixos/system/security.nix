{ ... }: let
  name = "hervyqa";
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
      wheelNeedsPassword = false;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["${name}"];
          groups = ["wheel"];
          keepEnv = true;
          noPass = true;
        }
      ];
      wheelNeedsPassword = false;
    };
  };
}

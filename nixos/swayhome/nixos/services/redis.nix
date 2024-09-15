{ ... }: let
  name = "nixos";
in {
  services = {
    redis = {
      servers = {
        "${name}" = {
          enable = true;
          port = 6379;
        };
      };
    };
  };
}

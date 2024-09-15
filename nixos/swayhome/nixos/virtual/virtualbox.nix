{ ... }: let
  name = "hervyqa";
in {
  virtualisation = {
    virtualbox = {
      guest = {
        enable = false;
      };
      host = {
        enable = false;
      };
    };
  };
  users = {
    extraGroups = {
      vboxusers = {
        members = [
        "${name}"
        ];
      };
    };
  };
}

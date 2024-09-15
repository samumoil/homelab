{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        ssh-agent = {
          enable = true;
        };
      };
    };
  };
}

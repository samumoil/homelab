{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      dconf = {
        settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        };
      };
    };
  };
}

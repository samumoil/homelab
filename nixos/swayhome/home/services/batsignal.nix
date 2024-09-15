{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      services = {
        batsignal = {
          enable = false;
          extraArgs = [
            "-c" "10"
            "-w" "30"
            "-f" "97"
          ];
        };
      };
    };
  };
}

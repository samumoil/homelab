{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      home = {
        packages = [
          acpi # show battery status and other acpi information
          clinfo # information about opencl platforms
          cpufetch # cpu fetching architecture tool
          dig # domain name server
          disfetch # distro fetching program
          dmidecode # reads information about system hardware
          dysk # get information on your mounted disks
          glxinfo # test utilities for opengl
          lshw # show your current hardware
        ];
      };
    };
  };
}

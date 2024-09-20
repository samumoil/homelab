# load broadcom wireless driver
#  boot.kernelModules = [ "wl" ];
#  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  
# blacklist similar modules to avoid collision
#  boot.blacklistedKernelModules = [ "b43" "bcma" ];


{
  config,
#  pkgs,
  ...
}:
with config;
#with pkgs;
{
  boot = {
    kernelModules = [
      "wl"
    ];
    blacklistedKernelModules = [
      "b43"
      "bcma"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
    ];
  };
}

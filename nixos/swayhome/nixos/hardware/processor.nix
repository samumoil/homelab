{
  config,
  lib,
  ...
}: {
  hardware = {
    cpu = {
      # amd or intel
      amd = {
        updateMicrocode =
         lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
  };
}

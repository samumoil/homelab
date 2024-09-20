{
  lib,
  ...
}: {
  networking = {
    useDHCP = lib.mkDefault true;
    #interfaces = {
      #enp3s0f0.useDHCP = lib.mkDefault true;
      #enp4s0.useDHCP = lib.mkDefault true;
      #wlp1s0.useDHCP = lib.mkDefault true;
    #};
  };
}

{
  pkgs,
  ...
}:
with pkgs;
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        amdvlk
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
    };
  };
}

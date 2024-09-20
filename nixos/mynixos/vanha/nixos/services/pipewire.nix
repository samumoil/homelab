{ ... }: {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = false;
        support32Bit = false;
      };
      jack.enable = false;
      pulse.enable = true;
    };
  };
}

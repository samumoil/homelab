{ ... }: {
  services = {
    clamav = {
      daemon = {
        enable = false;
      };
      updater = {
        enable = false;
      };
    };
  };
}

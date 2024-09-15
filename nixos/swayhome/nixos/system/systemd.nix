{ ... }: {
  systemd = {
    oomd = {
      enable = false; # Switch to earlyoom.
    };
  };
}

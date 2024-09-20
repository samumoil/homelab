{ ... }: {
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
    man = {
      generateCaches = true;
    };
  };
}

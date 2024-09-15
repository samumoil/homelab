{ ... }: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/56f0a8d0-7c8b-4849-9d18-def00c2a7b47";
      fsType = "ext4";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/7403caac-87c5-46c4-896e-bc74a3ba8b95";
      fsType = "ext4";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/ABD9-665E";
      fsType = "vfat";
    };
  };
}

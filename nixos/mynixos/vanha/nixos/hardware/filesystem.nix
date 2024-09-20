{ ... }: {

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/52ad1de5-efe1-456c-b16c-676c80a18aab";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-010609cb-a4b0-4e69-9d42-7449e82409dd".device = "/dev/disk/by-uuid/010609cb-a4b0-4e69-9d42-7449e82409dd";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F1E2-47DB";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}

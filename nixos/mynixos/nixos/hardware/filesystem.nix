{ ... }: {

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/66175c3f-db14-47c4-9e1b-7e454b9dc4a6";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-204a4f62-3984-4744-9e43-8f06083d7477".device = "/dev/disk/by-uuid/204a4f62-3984-4744-9e43-8f06083d7477";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/862C-9079";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}



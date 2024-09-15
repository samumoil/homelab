{
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./filesystem.nix
    ./graphics.nix
    ./networking.nix
    ./platform.nix
    ./processor.nix
    ./sane.nix
    ./sound.nix
    ./swapdevices.nix
  ];
}

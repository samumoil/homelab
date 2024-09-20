{
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./filesystem.nix
#    ./graphics.nix 	# Only for 24.11 / unstable
    ./networking.nix
    ./platform.nix
    ./processor.nix
#    ./sane.nix
#    ./sound.nix 	# No idea? Text is same as sane.nix
    ./swapdevices.nix
  ];
}

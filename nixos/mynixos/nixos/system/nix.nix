{ ... }: let
  name = "sam";
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than 7d";
    };
#    optimise = {
#      automatic = true;
#    };
    extraOptions = ''
      experimental-features = nix-command flakes
#      keep-outputs = true
#      keep-derivations = true
    '';
    settings = {
      allowed-users = ["@wheel"];
#      auto-optimise-store = true;
      sandbox = true;
      trusted-users = ["root" "${name}"];
    };
  };
}
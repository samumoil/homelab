{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      home = {
        packages = [
          (
            haskellPackages.ghcWithPackages (p:
              with p; [
                aeson
                async
                conduit
                containers
                esqueleto
                ghc
                ghcid
                hlint
                hpack
                lens
                pandoc
                parsec
                stack
                stm
                text
                vector
              ]
            )
          )
        ];
      };
    };
  };
}

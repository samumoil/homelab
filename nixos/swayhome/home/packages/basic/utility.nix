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
          bootiso
          devenv
          dstask
          duf
          efibootmgr
          fig2dev
          ffsend
          gdrive3
          glib
          hexyl
          inetutils
          jmtpfs
          libva-utils
          nix-health
          nix-search-cli
          nvme-cli
          parted
          ps_mem
          psmisc
          rnm
          rtorrent
          scrcpy
          toipe
          tree
          ttyper
          typioca
          upterm
          usbutils
          ventoy
          vulkan-tools
          vulnix
          w3m
          xdg-utils
        ];
      };
    };
  };
}

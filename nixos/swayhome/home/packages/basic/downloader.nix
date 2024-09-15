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
          axel # console downloading program
          downonspot # spotify downloader written in rust
          libgen-cli # used to access the library genesis dataset
          tdl # telegram downloader/tools written in golang
          wget # cli downloader
          youtube-tui # an aesthetically pleasing youtube tui
          ytmdl # youtube music downloader
        ];
      };
    };
  };
}

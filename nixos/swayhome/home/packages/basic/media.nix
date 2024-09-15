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
          exiftool # exif meta information
          ffmpeg # convert video
          ffmpegthumbnailer # lightweight video thumbnailer
          glow # markdown renderer
          imagemagick # convert image
          inxi # info for device specification
          mediainfo # info for image file
          mpc-cli # minimalist command line interface to mpd
          mpvpaper # video wallpaper program for wlroots
          optipng # a png optimizer
          pamixer # audio volume
          scour # compress svg
          tagutil # scriptable music files tags tool and editor
        ];
      };
    };
  };
}

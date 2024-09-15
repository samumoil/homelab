{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      xdg = {
        configFile = {
          "mimeapps.list".force = true;
        };
        mimeApps = let
          discord = "discord.desktop";
          gimp = "gimp.desktop";
          helix = "Helix.desktop";
          imv = "imv.desktop";
          inkscape = "org.inkscape.Inkscape.desktop";
          krita = "krita_psd.desktop";
          mpv = "mpv.desktop";
          neovim = "nvim.desktop";
          pcmanfm = "pcmanfm.desktop";
          qutebrowser = "org.qutebrowser.qutebrowser.desktop";
          zathura = "org.pwmt.zathura.desktop";
        in {
          enable = true;
          associations.added = {
            "application/pdf" = [ zathura ];
            "application/vnd.ms-publisher" = [ helix neovim ];
            "application/x-extension-htm" = [ qutebrowser ];
            "application/x-extension-html" = [ qutebrowser ];
            "application/x-extension-shtml" = [ qutebrowser ];
            "application/x-extension-xht" = [ qutebrowser ];
            "application/x-extension-xhtml" = [ qutebrowser ];
            "application/xhtml+xml" = [ qutebrowser ];
            "application/xml" = [ helix neovim ];
            "audio/aac" = [ mpv ];
            "audio/flac" = [ mpv ];
            "audio/mp4" = [ mpv ];
            "audio/mpeg" = [ mpv ];
            "audio/ogg" = [ mpv ];
            "audio/x-wav" = [ mpv ];
            "image/gif" = [ imv ];
            "image/jpeg" = [ imv ];
            "image/png" = [ imv ];
            "image/svg+xml" = [ inkscape ];
            "image/vnd.adobe.photoshop" = [ krita ];
            "image/webp" = [ imv ];
            "image/x-eps" = [ inkscape ];
            "image/x-xcf" = [ gimp ];
            "inode/directory" = [ pcmanfm ];
            "text/html" = [ qutebrowser ];
            "text/markdown" = [ helix neovim ];
            "text/plain" = [ helix neovim ];
            "text/uri-list" = [ qutebrowser ];
            "video/mp4" = [ mpv ];
            "video/ogg" = [ mpv ];
            "video/webm" = [ mpv ];
            "video/x-flv" = [ mpv ];
            "video/x-matroska" = [ mpv ];
            "video/x-ms-wmv" = [ mpv ];
            "video/x-ogm+ogg" = [ mpv ];
            "video/x-theora+ogg" = [ mpv ];
            "x-scheme-handler/about" = [ qutebrowser ];
            "x-scheme-handler/chrome" = [ qutebrowser ];
            "x-scheme-handler/discord" = [ discord ];
            "x-scheme-handler/ftp" = [ qutebrowser ];
            "x-scheme-handler/http" = [ qutebrowser ];
            "x-scheme-handler/https" = [ qutebrowser ];
            "x-scheme-handler/unknown" = [ qutebrowser ];
          };
          defaultApplications = {
            "application/pdf" = [ zathura ];
            "application/vnd.ms-publisher" = [ helix neovim ];
            "application/x-extension-htm" = [ qutebrowser ];
            "application/x-extension-html" = [ qutebrowser ];
            "application/x-extension-shtml" = [ qutebrowser ];
            "application/x-extension-xht" = [ qutebrowser ];
            "application/x-extension-xhtml" = [ qutebrowser ];
            "application/xhtml+xml" = [ qutebrowser ];
            "application/xml" = [ helix neovim ];
            "audio/aac" = [ mpv ];
            "audio/flac" = [ mpv ];
            "audio/mp4" = [ mpv ];
            "audio/mpeg" = [ mpv ];
            "audio/ogg" = [ mpv ];
            "audio/x-wav" = [ mpv ];
            "image/gif" = [ imv ];
            "image/jpeg" = [ imv ];
            "image/png" = [ imv ];
            "image/svg+xml" = [ inkscape ];
            "image/vnd.adobe.photoshop" = [ krita ];
            "image/webp" = [ imv ];
            "image/x-eps" = [ inkscape ];
            "image/x-xcf" = [ gimp ];
            "inode/directory" = [ pcmanfm ];
            "text/html" = [ qutebrowser ];
            "text/markdown" = [ helix neovim ];
            "text/plain" = [ helix neovim ];
            "text/uri-list" = [ qutebrowser ];
            "video/mp4" = [ mpv ];
            "video/ogg" = [ mpv ];
            "video/webm" = [ mpv ];
            "video/x-flv" = [ mpv ];
            "video/x-matroska" = [ mpv ];
            "video/x-ms-wmv" = [ mpv ];
            "video/x-ogm+ogg" = [ mpv ];
            "video/x-theora+ogg" = [ mpv ];
            "x-scheme-handler/about" = [ qutebrowser ];
            "x-scheme-handler/chrome" = [ qutebrowser ];
            "x-scheme-handler/discord" = [ discord ];
            "x-scheme-handler/ftp" = [ qutebrowser ];
            "x-scheme-handler/http" = [ qutebrowser ];
            "x-scheme-handler/https" = [ qutebrowser ];
            "x-scheme-handler/unknown" = [ qutebrowser ];
          };
        };
      };
    };
  };
}

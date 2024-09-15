{ ... }: let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      programs = {
        firefox = {
          enable = false;
          profiles = {
            ${name} = {
              isDefault = true;
              search = {
                default = "DuckDuckGo";
                force = true;
                privateDefault = "DuckDuckGo";
              };
              settings = {
                "browser.aboutConfig.showWarning" = false;
                "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                "browser.newtabpage.activity-stream.feeds.snippets" = false;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
                "browser.newtabpage.activity-stream.showSearch" = false;
                "browser.sessionstore.resume_session_once" = true;
                "browser.shell.checkDefaultBrowser" = false;
                "browser.toolbars.bookmarks.visibility" = "never";
                "browser.warnOnQuit" = false;
                "devtools.theme" = "dark";
                "full-screen-api.transition-duration.enter" = "0 0";
                "full-screen-api.transition-duration.leave" = "0 0";
                "full-screen-api.transition.timeout" = 0;
                "gfx.webrender.all" = true;
                "media.ffmpeg.low-latency.enabled" = true;
                "media.ffmpeg.vaapi.enabled" = true;
                "media.ffvpx.enabled" = false;
                "media.navigator.mediadatadecoder_vpx_enabled" = true;
                "media.rdd-vpx.enabled" = false;
                "security.sandbox.content.level" = 0;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "ui.prefersReducedMotion" = 1;
              };
              userChrome = ''
                #webrtcIndicator {
                  display: none;
                }
              '';
            };
          };
          policies = {
            CaptivePortal = false;
            DisableAppUpdate = true;
            DisableFirefoxAccounts = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableSetDesktopBackground = true;
            DisableTelemetry = true;
            FirefoxHome = {
              Pocket = false;
              Snippets = false;
            };
            ShowHomeButton = false;
            UserMessaging = {
              ExtensionRecommendations = false;
              SkipOnboarding = true;
            };
          };
        };
      };
    };
  };
}

{
  pkgs,
  ...
}:
with pkgs;
{
  programs = {
    gnupg = {
      agent = {
        enable = false;
        enableSSHSupport = true;
        pinentryPackage = pinentry-gnome3;
      };
    };
  };
}

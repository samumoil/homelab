{
  pkgs,
  ...
}:
with pkgs;
let
  name = "sam";
  fullname = "...";
in {
  users = {
    defaultUserShell = zsh;
    users = {
      ${name} = {
        isNormalUser = true;
        description = "${fullname}";
        uid = 1000;
        extraGroups = [
          "adbusers"
          "audio"
          "disk"
          "input"
          "libvirtd"
          "lp"
          "mysql"
          "postgres"
          "systemd-journal"
          "users"
          "video"
          "wheel"
          "ydotool"
        ];
      };
      taat = {
        isNormalUser = true;
        description = "taat";
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };
  };
}

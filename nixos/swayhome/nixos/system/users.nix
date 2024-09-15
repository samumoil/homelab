{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
  fullname = "Hervy Qurrotul Ainur Rozi";
in {
  users = {
    defaultUserShell = fish;
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
    };
  };
}

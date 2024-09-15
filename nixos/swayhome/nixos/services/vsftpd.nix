{ ... }: let
  name = "hervyqa";
in {
  services = {
    vsftpd = {
      enable = true;
      localUsers = true;
      writeEnable = true;
      userlist = [
       "${name}"
      ];
    };
  };
}

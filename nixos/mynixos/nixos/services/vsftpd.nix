{ ... }: let
  name = "sam";
in {
  services = {
    vsftpd = {
      enable = false;
      localUsers = true;
      writeEnable = true;
      userlist = [
       "${name}"
      ];
    };
  };
}

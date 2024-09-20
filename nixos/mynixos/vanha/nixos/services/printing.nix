{
  pkgs,
  ...
}:
with pkgs;
{
  services = {
    printing = {
      enable = true;
      stateless = true;
      webInterface = false;
      drivers = [
        epson-escpr
        epson-escpr2
        foomatic-db
        gutenprint
        hplip
        splix
      ];
    };
  };
}

{ ... }: let
  defaultlocale = "en_US.UTF-8";
  extralocale = "en_US.UTF-8";
in {
  i18n = {
    defaultLocale = "${defaultlocale}";
    extraLocaleSettings = {
      LANGUAGE = "${defaultlocale}";
      LC_ADDRESS = "${extralocale}";
      LC_COLLATE = "${extralocale}";
      LC_CTYPE = "${extralocale}";
      LC_IDENTIFICATION = "${extralocale}";
      LC_MEASUREMENT = "${extralocale}";
      LC_MESSAGES = "${extralocale}";
      LC_MONETARY = "${extralocale}";
      LC_NAME = "${extralocale}";
      LC_NUMERIC = "${extralocale}";
      LC_PAPER = "${extralocale}";
      LC_TELEPHONE = "${extralocale}";
      LC_TIME = "${extralocale}";
    };
  };
}

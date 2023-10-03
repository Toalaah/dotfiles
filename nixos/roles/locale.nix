{config, ...}: let
  locale = config.attributes.primaryUser.locale;
in {
  i18n = {
    defaultLocale = locale;
    supportedLocales = ["all"];
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = "de_DE.UTF-8"; # metric
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };
}

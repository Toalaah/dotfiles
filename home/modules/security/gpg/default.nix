{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.security.gpg;
  user = config.attributes.primaryUser;
  hasGpgKey = user.gpgKey != null;
  hasSshKeys = user.sshKeys != [];
in {
  options.security.gpg = {
    enable = mkEnableOption "gpg and gpg-agent";
    sshSupport = mkEnableOption "configure gpg-agent with ssh-support";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.enable -> hasGpgKey;
          message = "gpg: need a gpg key in order to enable gpg";
        }
        {
          assertion = cfg.sshSupport -> hasSshKeys;
          message = "gpg: need an ssh key in order to enable ssh support";
        }
      ];
      programs.gpg = {
        enable = true;
        settings = {
          homedir = "${config.xdg.dataHome}/gnupg";
          keyid-format = "long";
          with-fingerprint = true;
          keyserver = "hkps://keys.openpgp.org";
        };
      };
      services.gpg-agent = {
        enable = true;
        enableSshSupport = cfg.sshSupport;
        sshKeys = config.attributes.primaryUser.sshKeys;
        pinentryFlavor = "gnome3";
        maxCacheTtl = 120;
        defaultCacheTtl = 60;
      };
    })
  ];
}

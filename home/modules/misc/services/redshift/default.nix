{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.misc.services.redshift;
in {
  options = with types; {
    misc.services.redshift = {
      enable = mkEnableOption "redshift";
      autoDetermineLocation = mkEnableOption "auto determine location via geoclue2. Note you will need to manually enable the service as well.";
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = lib.optional cfg.autoDetermineLocation pkgs.geoclue2;
      services.redshift = {
        enable = true;
        provider =
          if cfg.autoDetermineLocation
          then "geoclue2"
          else "manual";
        settings = {
          redshift = {
            temp-day = lib.mkForce 5300;
            temp-night = lib.mkForce 3500;
            fade = 1;
            brightness-day = 1.0;
            brightness-night = 0.9;
            gamma = 0.8;
            adjustment-method = "randr";
          };
          manual = {
            lat = 52;
            lon = 13;
          };
          randr.screen = 0;
        };
      };
    })
  ];
}

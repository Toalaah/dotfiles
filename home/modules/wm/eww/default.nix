{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wm.eww;
in {
  options = {
    wm.eww.enable = mkEnableOption "eww";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [];
      programs.eww = {
        enable = true;
        package = pkgs.eww;
        configDir = ./config;
      };
    })
  ];
}

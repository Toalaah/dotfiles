{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wm.eww;
  ewwConfig = builtins.attrNames (builtins.readDir ./configs);
in {
  options = {
    wm.eww = {
      enable = mkEnableOption "eww";
      configuration = mkOption {
        default = "default";
        description = "eww confgiuration to apply";
        type = types.enum ewwConfig;
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [];
      programs.eww = {
        enable = true;
        package = pkgs.eww;
        configDir = ./configs + "/${cfg.configuration}";
      };
    })
  ];
}

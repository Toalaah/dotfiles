{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dev.git.lazygit;
  primitive = with types; oneOf [bool int float str];
in {
  options.dev.git = {
    lazygit = {
      enable = mkEnableOption "lazygit";
      settings = mkOption {
        type = with types; attrsOf (either primitive (listOf primitive));
        default = {};
        description = "additional lazygit settings";
      };
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = config.dev.git.enable;
          message = "git needs to be enabled for this service to work";
        }
      ];
      programs.lazygit = {
        enable = true;
        settings = cfg.settings;
      };
    })
  ];
}

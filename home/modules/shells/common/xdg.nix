{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.shells.common;
  home = config.home.homeDirectory;
in {
  options = {
    shells.common.enable = mkOption {
      default = true;
      type = types.bool;
      description = "whether to enable common shell variables, aliases, etc.";
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      home.sessionVariables = {
        XDG_CONFIG_HOME = "${home}/.config";
        XDG_DATA_HOME = "${home}/.local/share";
        XDG_CACHE_HOME = "${home}/.cache";
        XDG_STATE_HOME = "${home}/.local/state";
      };
    })
  ];
}

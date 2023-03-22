{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.tools.zoxide;
  mkDefaultTrueOption = s: mkEnableOption s // {default = true;};
in {
  options = {
    tools.zoxide = {
      enable = mkEnableOption "zoxide";
      extraOptions = mkOption {
        default = [];
        type = types.listOf types.str;
        description = "additional options to set";
      };
      enableZshIntegration = mkDefaultTrueOption "enable zoxide-related zsh integration";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
        options = [] ++ cfg.extraOptions;
      };
    })
    (mkIf (cfg.enable && config.shells.zsh.enable) {
      programs.zsh.initExtra = lib.optionalString cfg.enableZshIntegration "bindkey -s '^f' 'zi^M'";
    })
  ];
}

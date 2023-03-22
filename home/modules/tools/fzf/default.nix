{
  config,
  lib,
  pkgs,
  fzf-tab,
  ...
}:
with lib; let
  cfg = config.tools.fzf;
  primitive = with types; oneOf [bool int float str];
  mkDefaultTrueOption = s: mkEnableOption s // {default = true;};
in {
  options = {
    tools.fzf = {
      enable = mkEnableOption "fzf";
      enableZshIntegration = mkDefaultTrueOption "enable fzf-related zsh integration";
      settingOverrides = mkOption {
        type = with types; attrsOf (either primitive (listOf primitive));
        default = {};
        description = "settings to override / add";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.fzf =
        lib.recursiveUpdate {
          enable = true;
          defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git --exclude node_modules";
          defaultOptions = [
            "--height 40%"
            "--color=bg+:1,gutter:-1"
            "--cycle "
            "--layout=reverse"
            "--border"
          ];
          fileWidgetOptions = [
            "--preview '${pkgs.bat}/bin/bat -n --color=always {}'"
            "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
            "--color header:italic"
            "--prompt 'Select File(s): '"
          ];
        }
        cfg.settingOverrides;
    })
    (mkIf (cfg.enable && config.shells.zsh.enable) {
      programs.zsh.plugins = [
        {
          name = "fzf-tab";
          src = fzf-tab;
        }
      ];
    })
  ];
}

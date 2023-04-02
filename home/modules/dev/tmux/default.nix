{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dev.tmux;
in {
  options = {
    dev.tmux.enable = mkEnableOption "tmux";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      programs.tmux = {
        terminal = "screen-256color";
        historyLimit = 50000;
        keyMode = "vi";
        clock24 = true;
        baseIndex = 1;
        mouse = true;
        newSession = true;
        prefix = "C-a";
        escapeTime = 0;
        extraConfig = builtins.readFile ./tmux.conf;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
          }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = "set -g @continuum-restore 'on'";
          }
        ];
      };
    })
  ];
}

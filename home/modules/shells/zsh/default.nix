{
  config,
  lib,
  zsh-nix-shell,
  ...
}:
with lib; let
  cfg = config.shells.zsh;
  primitive = with types; oneOf [bool int float str];
  defaultTrue = s: mkEnableOption s // {default = true;};
in {
  options = {
    shells.zsh = {
      enable = mkEnableOption "zsh";
      settingOverrides = mkOption {
        type = with types; attrsOf (either primitive (listOf primitive));
        default = {};
        description = "settings to override / add";
      };
      options = mkOption {
        type = types.listOf types.str;
        default = [
          "NO_BEEP"
          "GLOB_DOTS"
          "INTERACTIVE_COMMENTS"
          "MENU_COMPLETE"
          "PUSHDSILENT"
          "CD_SILENT"
        ];
        description = "options to set (see setopt builtin shell function)";
      };
      enableSyntaxHighlighting = defaultTrue "syntax highlighting";
      enableAutosuggestions = defaultTrue "autosuggestions";
    };
  };

  config = let
    defaultZshSettings = {
      enable = lib.mkForce true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      enableSyntaxHighlighting = cfg.enableSyntaxHighlighting;
      enableAutosuggestions = cfg.enableAutosuggestions;
      autocd = true;
      initExtra = ''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        autoload edit-command-line
        zle -N edit-command-line
        bindkey -v
        bindkey "^e" edit-command-line
        bindkey "^p" up-history
        bindkey "^n" down-history
        ${lib.optionalString cfg.enableAutosuggestions "bindkey '^ ' autosuggest-accept"}
        ${lib.strings.concatMapStringsSep "\n" (opt: "setopt ${opt}") cfg.options}
      '';
      profileExtra = "";
      history = {
        path = "${config.xdg.cacheHome}/zsh/zsh_history";
        ignorePatterns = ["ls" "ll"];
        ignoreSpace = true;
        size = 50000;
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = zsh-nix-shell;
        }
      ];
    };
  in
    mkMerge [
      (mkIf cfg.enable {
        programs.zsh = lib.recursiveUpdate defaultZshSettings cfg.settingOverrides;
        programs.starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            status = {disabled = false;};
            character = {
              vimcmd_symbol = "[ N](bold green) ";
              vimcmd_replace_one_symbol = "[ R](bold purple) ";
              vimcmd_replace_symbol = "[ R](bold purple) ";
              vimcmd_visual_symbol = "[ V](bold yellow) ";
            };
          };
        };
      })
    ];
}

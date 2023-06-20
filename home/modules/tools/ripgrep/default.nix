{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tools.ripgrep;
in {
  options = {
    tools.ripgrep = {
      enable = mkEnableOption "ripgrep";
      globalIgnores = mkOption {
        description = "global ignores";
        default = [
          "!.env"
          ".DS_Store"
          ".direnv"
          "node_modules"
        ];
        type = types.listOf types.str;
      };
      extraSettings = mkOption {
        description = "additional settings";
        default = ''
        '';
        type = types.lines;
      };
    };
  };
  config = let
    configDir = "${config.xdg.configHome}/ripgrep";
    configFile = "${configDir}/ripgreprc";
    ignoreFile = "${configDir}/ignore";
  in
    mkMerge [
      (mkIf cfg.enable {
        home.packages = [pkgs.ripgrep];
        home.file.${ignoreFile}.text = strings.concatStringsSep "\n" cfg.globalIgnores;
        home.file.${configFile}.text = cfg.extraSettings + "\n--ignore-file=${ignoreFile}";
        home.sessionVariables.RIPGREP_CONFIG_PATH = configFile;
      })
    ];
}

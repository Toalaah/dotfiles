{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dev.git.gh;
  primitive = with types; oneOf [bool int float str];
in {
  options.dev.git = {
    gh = {
      enable = mkEnableOption "github cli";
      protocol = mkOption {
        type = types.enum ["ssh" "https"];
        default = "ssh";
        description = "protocol to use";
      };
      extensions = mkOption {
        type = with types; listOf string;
        default = [];
        description = "extensions to enable";
      };
      extraSettings = mkOption {
        type = with types; attrsOf (either primitive (listOf primitive));
        default = {};
        description = "additional settings";
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
      programs.gh = {
        enable = true;
        settings = cfg.extraSettings // {git_protocol = cfg.protocol;};
        extensions = cfg.extensions;
      };
    })
  ];
}

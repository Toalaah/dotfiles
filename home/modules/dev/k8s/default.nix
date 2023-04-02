{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dev.k8s;
  k9sThemes = builtins.map (x: strings.removeSuffix ".nix" x) (builtins.attrNames (builtins.readDir ./k9s/themes));
  primitive = with types; oneOf [bool int float str];
in {
  options = {
    dev.k8s = {
      kind.enable = mkEnableOption "kind";
      k9s = {
        enable = mkEnableOption "k9s";
        extraConfig = mkOption {
          type = with types; attrsOf (either primitive (listOf primitive));
          default = {};
          description = "additional k9s settings";
        };
        theme = mkOption {
          type = types.nullOr (types.enum k9sThemes);
          default = null;
          description = "skin to use for k9s";
        };
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.k9s.enable or cfg.kind.enable {
      home.packages =
        [
          pkgs.kubectl
        ]
        ++ lib.optionals cfg.kind.enable [
          pkgs.kind
        ];
      programs.k9s = {
        enable = cfg.k9s.enable;
        settings =
          {
            refreshRate = 2;
          }
          // cfg.k9s.extraConfig;
        skin =
          if (cfg.k9s.theme != null)
          then (import ./k9s/themes/${cfg.k9s.theme}.nix)
          else {};
      };
    })
  ];
}

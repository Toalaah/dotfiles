{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.tools.binscripts;
in {
  options = {
    tools.binscripts.addToPath = mkEnableOption "add bin scripts to path" // {default = true;};
  };
  config = mkMerge [
    (mkIf cfg.addToPath {
      home.sessionPath = [(builtins.toString ./scripts)];
    })
  ];
}

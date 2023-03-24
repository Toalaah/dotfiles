{
  config,
  dmenu,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tools.dmenu;
in {
  options = {
    tools.dmenu.enable = mkEnableOption "dmenu";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      # TODO: expose more options in upstream flake, ex: changing font-size, cursor, ...
      home.packages = [dmenu.packages.${pkgs.system}.default];
    })
  ];
}

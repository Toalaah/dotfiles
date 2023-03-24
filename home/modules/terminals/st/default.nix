{
  config,
  lib,
  pkgs,
  st,
  ...
}:
with lib; let
  system = pkgs.system;
  cfg = config.terminals.st;
in {
  options.terminals.st.enable = mkEnableOption "st";
  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.enable -> !config.terminals.alacritty.enable;
          message = "Only one terminal emulator should be enabled at a time";
        }
      ];
      # TODO: expose more options in upstream flake, ex: changing font-size, cursor, ...
      attributes.primaryUser.terminal = "${st.defaultPackage.${system}}/bin/st";
      home.packages = [st.defaultPackage.${system}];
    })
  ];
}

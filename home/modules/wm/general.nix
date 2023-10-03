{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wm.general;
  currentWindowManager = config.attributes.primaryUser.windowManager;
in {
  imports = [./tint2];
  options.wm.general = {
    displayManager = mkOption {
      type = types.enum ["none" "xinit"];
      default = "xinit";
      description = "display manager to use";
    };
  };

  config = let
    xsession = "${config.home.homeDirectory}/.xsession";
  in
    mkMerge [
      (mkIf (cfg.displayManager == "xinit")
        {
          assertions = [
            {
              assertion = currentWindowManager != null;
              message = "a window manager / desktop environment must be specified";
            }
          ];
          # allows using xinitrc / sxrc
          home.file.".xinitrc".source = config.lib.file.mkOutOfStoreSymlink xsession;
          xdg.configFile."sx/sxrc".source = config.lib.file.mkOutOfStoreSymlink xsession;
        })
    ];
}

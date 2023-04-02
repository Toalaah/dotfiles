{
  config,
  dmenu,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tools.dmenu;
  dmenu' = dmenu.packages.${pkgs.system}.dmenu;
in {
  options = {
    tools.dmenu = {
      enable = mkEnableOption "dmenu";
      sxhkdIntegration = {
        enable = mkEnableOption "add dmenu scripts to sxhkd keybindings";
        runOpts = mkOption {
          type = types.str;
          default = "-l 20 -c";
          description = "default options to pass to `dmenu_run` keybinding";
        };
      };
      scripts = {
        addToPath = mkEnableOption "add dmenu scripts to path" // {default = true;};
      };
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      # TODO: expose more options in upstream flake, ex: changing font-size, cursor, ...
      home.packages = [dmenu'];
      home.sessionPath = lib.optional cfg.scripts.addToPath (builtins.toString ./scripts);
    })

    (mkIf (cfg.enable && cfg.sxhkdIntegration.enable) {
      assertions = [
        {
          assertion = config.wm.sxhkd.enable;
          message = "dmenu: sxhkd service must be enabled to use keybindings";
        }
      ];
      services.sxhkd = {
        enable = true;
        keybindings = {
          "super + p" = "${dmenu'}/bin/dmenu_run ${cfg.sxhkdIntegration.runOpts}";
          "super + b; {p,b}" = "${./scripts}/dmenu-{pass,bookmarks}";
          "super + F{2,3,4,6}" = "${./scripts}/dmenu-{net,mount,vpn,logout}";
        };
      };
    })
  ];
}

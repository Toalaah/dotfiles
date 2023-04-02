{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wm.bspwm;
in {
  options.wm.bspwm = {
    enable = mkEnableOption "Bspwm";
    numDesktops = mkOption {
      type = types.numbers.between 1 9;
      default = 6;
      description = "Number of desktops";
    };
    statusBar = mkOption {
      type = types.enum ["none" "eww"];
      default = "eww";
      description = "which status bar to use";
    };
  };

  config = let
    bspwm = "${config.xsession.windowManager.bspwm.package}/bin/bspwm";
  in
    mkMerge [
      (mkIf cfg.enable {
        assertions = import ./assertions.nix {inherit config cfg bspwm;};
        # append bspwm-specific keybindings to sxhkd config
        services.sxhkd.keybindings = import ./keybindings.nix {inherit pkgs;};
        attributes.primaryUser.windowManager = bspwm;
        # enable services required for bspwm to function
        wm.eww.enable = mkDefault (cfg.statusBar == "eww");
        wm.sxhkd.enable = mkDefault true;
        # bspwm config
        xsession.windowManager.bspwm = {
          enable = true;
          extraConfigEarly = import ./startupScript.nix {inherit config cfg pkgs lib;};
          extraConfig = ''
            xsetroot -cursor_name left_ptr
          '';
          alwaysResetDesktops = true;
          settings = {
            border_width = 2;
            focused_border_colour = "#FFFFFF";
            window_gap = 4;
            split_ratio = 0.50;
            focus_follows_pointer = true;
            borderless_monocle = true;
            gapless_monocle = true;
            pointer_action1 = "move";
            pointer_action2 = "resize_corner";
            pointer_modifier = "mod4";
          };
          rules = {
            Zathura = {
              state = "tiled";
            };
          };
          monitors = {
            primary = with lib.lists; forEach (range 1 cfg.numDesktops) (x: builtins.toString x);
          };
        };
      })
    ];
}

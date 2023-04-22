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
    enable = mkEnableOption "bspwm";
    numDesktops = mkOption {
      type = types.numbers.between 1 9;
      default = 6;
      description = "number of desktops to use";
    };
    desktops = mkOption {
      type = types.attrsOf (types.submodule {
        options.name = mkOption {
          type = types.str;
          description = "name to give to this desktop";
        };
      });
      default = {};
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
        warnings = let
          allowedDesktopNames = builtins.map (x: builtins.toString x) (lib.range 1 cfg.numDesktops);
          invalidDesktopNames = builtins.attrNames (lib.attrsets.filterAttrs (n: _: ! builtins.elem n allowedDesktopNames) cfg.desktops);
          printWarning = x: "bspwm: invalid desktop index '${x}' will be ignored, it is either not a number or is out of the accepted range";
        in
          optionals (invalidDesktopNames != []) (builtins.map printWarning invalidDesktopNames);
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
            focused_border_color = "#FFFFFF";
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
          monitors = with lib.lists; let
            desktops = range 1 cfg.numDesktops;
          in {
            primary = imap1 (idx: val: cfg.desktops.${builtins.toString idx}.name or (builtins.toString val)) desktops;
          };
        };
      })
    ];
}

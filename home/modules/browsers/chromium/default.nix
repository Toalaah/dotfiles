{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.browsers.chromium;
in {
  options = {
    browsers.chromium = {
      enable = mkEnableOption "chromium";
      ungoogled = mkEnableOption "use ungoogled chromium package";
      darkMode = mkEnableOption "dark mode";
      additionalExtensions = mkOption {
        default = [];
        description = "additional extensions to install";
      };
    };
  };
  config = let
    package =
      if cfg.ungoogled
      then pkgs.ungoogled-chromium
      else pkgs.chromium;
  in
    mkMerge [
      (mkIf cfg.enable {
        assertions = [
          {
            assertion = ! config.browsers.firefox.enable;
            message = "chromium: only one browser should be enabled";
          }
        ];
        attributes.primaryUser.browser = "${package}/bin/chromium";
        home.sessionVariables.BROWSER = "${package}/bin/chromium";
        programs.chromium = {
          enable = true;
          inherit package;
          commandLineArgs =
            []
            # TODO: CLI args apparently don't work when using custom package. Maybe manually create ~/.config/chromium-flags.conf instead?
            ++ lib.optionals cfg.darkMode [
              "--enable-features=WebUIDarkMode"
              "--force-dark-mode"
            ];
          # TODO: add some more extensions when I actually switch back to using this browser
          extensions = [
            {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
          ];
        };
      })
    ];
}

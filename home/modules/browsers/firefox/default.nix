{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.browsers.firefox;
in {
  options = {
    browsers.firefox = {
      enable = mkEnableOption "firefox";
      additionalExtensions = mkOption {
        default = [];
        description = "additional extensions to install";
      };
    };
  };
  # TODO: integrate with bookmarks stored in user attributes
  config = mkMerge [
    (mkIf cfg.enable {
      attributes.primaryUser.browser = "${config.programs.firefox.package}/bin/firefox";
      home.sessionVariables.BROWSER = "${config.programs.firefox.package}/bin/firefox";
      programs.firefox = {
        enable = true;
        profiles."default" = {
          id = 0;
          isDefault = true;
          name = "Default";
          extensions = with pkgs.nur.repos.rycee.firefox-addons; let
            https-everywhere =
              buildFirefoxXpiAddon
              {
                pname = "https-everywhere";
                version = "2022.5.11";
                addonId = "https-everywhere-eff@eff.org";
                url = "https://eff.org/files/https-everywhere-2022.5.11-eff.xpi";
                sha256 = "sha256-6jO2I4Q2wKZ5FWxi7OFZwFTdTPnA5qYZtAVTUnEWTYU=";
                meta = with lib; {
                  homepage = "https://www.eff.org/https-everywhere";
                  description = "__MSG_about_ext_description__";
                  platforms = platforms.all;
                };
              };
          in
            [
              darkreader
              foxyproxy-standard
              violentmonkey
              ublock-origin
              vimium
              decentraleyes
              link-cleaner
              https-everywhere
              privacy-badger
            ]
            ++ cfg.additionalExtensions;
          userChrome = builtins.readFile ./userChrome.css;
          userContent = builtins.readFile ./userContent.css;
          settings = {
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "full-screen-api.warning.timeout" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.discovery.enabled" = false;
            "browser.compactmode.show" = true;
            "browser.startup.homepage" = "about:blank";
          };
        };
      };
    })
  ];
}
{
  config,
  firefox-nightly,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.browsers.firefox;
  firefoxNightlyPkg = firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
in {
  options = {
    browsers.firefox = {
      enable = mkEnableOption "firefox";
      useNightly = mkEnableOption "use nightly firefox build";
      passIntegration = mkEnableOption "integration with unix pass utility" // {default = true;};
      mpvIntegration = mkEnableOption "integration with ff2mpv" // {default = true;};
      additionalExtensions = mkOption {
        default = [];
        description = "additional extensions to install";
      };
    };
  };
  # TODO: integrate with bookmarks stored in user attributes
  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = ! config.browsers.chromium.enable;
          message = "firefox: only one browser should be enabled";
        }
      ];
      home.packages = lib.optionals cfg.mpvIntegration [pkgs.ff2mpv];
      attributes.primaryUser.browser = "${config.programs.firefox.package}/bin/firefox${lib.optionalString cfg.useNightly "-nightly"}";
      home.sessionVariables.BROWSER = "${config.programs.firefox.package}/bin/firefox${lib.optionalString cfg.useNightly "-nightly"}";
      home.file = {
        ".mozilla/native-messaging-hosts/passff.json" = mkIf cfg.passIntegration {source = "${pkgs.passff-host}/share/passff-host/passff.json";};
        ".mozilla/native-messaging-hosts/ff2mpv.json" = mkIf cfg.mpvIntegration {source = "${pkgs.ff2mpv}/lib/mozilla/native-messaging-hosts/ff2mpv.json";};
      };
      programs.firefox = let
        pkg =
          if cfg.useNightly
          then firefoxNightlyPkg
          else pkgs.firefox;
        package = pkg.override {
          cfg = {
            extraNativeMessagingHosts = lib.optional cfg.passIntegration pkgs.passff-host;
          };
        };
      in {
        enable = true;
        inherit package;
        profiles."default" = {
          id = 0;
          isDefault = true;
          name = "Default";
          extensions = with pkgs.nur.repos.rycee.firefox-addons; let
            # manifest URLs can be found here: about:debugging#/runtime/this-firefox
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
            passff =
              buildFirefoxXpiAddon
              {
                pname = "passff";
                version = "1.14.1";
                addonId = "passff@invicem.pro";
                url = "https://addons.mozilla.org/firefox/downloads/file/4069548/passff-1.14.1.xpi";
                sha256 = "sha256-RlwgQhK5NUbSDcj+8smayLBrLYhM0tOKr3PYJci+c4M=";
                meta = with lib; {
                  homepage = "https://github.com/passff/passff";
                  description = "Integrates your zx2c4 password store into Firefox";
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
            ++ cfg.additionalExtensions
            ++ lib.optional cfg.passIntegration passff
            ++ lib.optional cfg.mpvIntegration ff2mpv;
          userChrome = builtins.readFile ./userChrome.css;
          userContent = builtins.readFile ./userContent.css;
          settings = {
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "full-screen-api.warning.timeout" = 0;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.discovery.enabled" = false;
            "browser.compactmode.show" = true;
            "browser.startup.homepage" = "about:blank";
            "browser.sessionstore.resume_from_crash" = false;
          };
        };
      };
    })
  ];
}

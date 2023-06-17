{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.security.yubikey;
in {
  options.security.yubikey = {
    enable = mkEnableOption "yubikey";
    id = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        The ID of the yubikey.
        run `nix-shell --command 'ykinfo -s' -p yubikey-personalization` to get the ID
      '';
    };
    pam.enable = mkEnableOption "yubikey pam support";
  };
  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        yubioath-flutter
        yubikey-manager
        yubikey-personalization
        yubico-pam
      ];

      services.udev.packages = [pkgs.yubikey-personalization];
      services.pcscd.enable = true;
    })

    (mkIf cfg.pam.enable {
      assertions = [
        {
          assertion = cfg.id != null;
          message = "yubikey id must be set for PAM support";
        }
      ];

      warnings = [
        ''
          Yubikey PAM configuration requires additional manual configuration, see the
          appropriate sections in the docs: https://nixos.wiki/wiki/Yubikey
        ''
      ];

      security.pam.services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };

      security.pam.yubico = {
        enable = true;
        debug = false;
        mode = "challenge-response";
        inherit (cfg) id;
      };
    })
  ];
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  user = config.attributes.primaryUser;
  cfg = config.networking.wg.enable;
in {
  options.networking.wg = {
    enable = mkEnableOption "serviceless (classic) wireguard support";
    passwordless = mkEnableOption "passwordless manipulation of wireguard interfaces";
  };

  config = mkMerge [
    (mkIf cfg.enable
      {
        environment.systemPackages = [pkgs.wireguard-tools];

        systemd.tmpfiles.rules = [
          "d /etc/wireguard 770 root root"
        ];

        security.sudo = {
          enable = true;
          extraRules = [
            {
              users = [user.name];
              commands = [
                {
                  command = "${pkgs.wireguard-tools}/bin/wg-quick";
                  options = ["NOPASSWD"];
                }
                {
                  command = "${pkgs.wireguard-tools}/bin/wg";
                  options = ["NOPASSWD"];
                }
              ];
            }
          ];
        };
      })
  ];
}

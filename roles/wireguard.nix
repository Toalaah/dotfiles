{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.wireguard-tools];

  # imperative wireguard configs per-system
  systemd.tmpfiles.rules = [
    "d /etc/wireguard 770 root root"
  ];

  security.sudo.extraRules = [
    {
      users = [config.attributes.primaryUser.name];
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
}

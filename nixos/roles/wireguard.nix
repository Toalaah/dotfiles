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

  # alias command to full path in order to use commands w/ sudo more conveniently
  environment.shellAliases."wg-quick" = "${pkgs.wireguard-tools}/bin/wg-quick";
  environment.shellAliases."wg" = "${pkgs.wireguard-tools}/bin/wg";
  # https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
  environment.shellAliases."sudo" = "sudo ";

  security.sudo.extraRules = [
    {
      users = [config.attributes.primaryUser.name];
      commands = [
        {
          command = "${pkgs.wireguard-tools}/bin/wg-quick *";
          options = ["NOPASSWD"];
        }
        {
          command = "${pkgs.wireguard-tools}/bin/wg *";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}

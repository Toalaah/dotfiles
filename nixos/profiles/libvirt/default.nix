{
  config,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.dconf.enable = true;
  users.users."${user.name}".extraGroups = ["libvirtd" "input"];

  environment.systemPackages = [pkgs.virt-manager];
}

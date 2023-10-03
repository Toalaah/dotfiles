{
  config,
  pkgs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.dconf.enable = true;
  users.users.${config.attributes.primaryUser.name}.extraGroups = ["libvirtd" "input"];

  environment.systemPackages = [pkgs.virt-manager];
}

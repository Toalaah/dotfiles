{
  config,
  pkgs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.dconf.enable = true;
  users.users.${config.attributes.primaryUser.name}.extraGroups = ["libvirtd" "input"];

  services.spice-vdagentd.enable = true;

  environment.systemPackages = [pkgs.virt-manager];
}

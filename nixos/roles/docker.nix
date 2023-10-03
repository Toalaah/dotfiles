{config, ...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  users.extraGroups.docker.members = [
    config.attributes.primaryUser.name
  ];
}

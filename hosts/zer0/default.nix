{
  config,
  pkgs,
  nvim-flake,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/modules
    nvim-flake.nixosModules.nvim
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_3;
  environment.systemPackages = [];

  programs.nvim = {
    enable = true;
    modules = [
      nvim-flake.lib.baseModules
    ];
    configuration = import ./config.nix;
  };


  users.users.${config.attributes.primaryUser.name}.password = "password";

  system.stateVersion = "22.11";
}

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0c6498dc-0a6e-47c9-9f08-0a6fa1f77986";
    fsType = "ext4";
  };

  # TODO: this might need to be /nix/store
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b1405977-f015-4872-9e39-dc1decf49505";
    fsType = "ext4";
  };

  fileSystems."/D" = {
    device = "/dev/disk/by-uuid/d58dffa6-e1c7-4198-bc52-c420f2e34242";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8E3E-8567";
    fsType = "vfat";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

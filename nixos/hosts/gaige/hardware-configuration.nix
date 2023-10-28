# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
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

  boot.initrd.availableKernelModules = ["thunderbolt" "xhci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c0b4428a-63a6-41ae-b10e-6c68b2d20dfc";
    fsType = "ext4";
  };

  # LUKS root fs
  boot.initrd.luks.devices."luks-38e8ccbb-f207-419b-bd17-8c7be91ef6c1".device = "/dev/disk/by-uuid/38e8ccbb-f207-419b-bd17-8c7be91ef6c1";
  # enable swap on LUKS
  boot.initrd.luks.devices."luks-2f2ee1d7-2a5a-4f01-b1ee-c28121cac2d4".device = "/dev/disk/by-uuid/2f2ee1d7-2a5a-4f01-b1ee-c28121cac2d4";
  boot.initrd.luks.devices."luks-2f2ee1d7-2a5a-4f01-b1ee-c28121cac2d4".keyFile = "/crypto_keyfile.bin";

  boot.swraid.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_6_5;
  boot.tmp.cleanOnBoot = true;

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/3310-CD7C";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/ba8ff139-ffcd-41dd-a5d8-0e26cc06858f";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

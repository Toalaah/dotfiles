{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  # hardware.nvidia.nvidiaPersistenced = true;
  # hardware.nvidia.forceFullCompositionPipeline = true;

  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  # hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
}

{ config, lib, pkgs, ... }:
{

  nixpkgs.config.nvidia.acceptLicense = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

#   boot.initrd.kernelModules = [ "nvidia" ];
#   boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
# 
  # try this if above still fails
#   boot.kernelParams = [ "module_blacklist=i915" ];

  # https://wiki.archlinux.org/title/NVIDIA_Optimus#Use_NVIDIA_graphics_only
#   boot.kernelParams = [ "rcutree.rcu_idle_gp_delay=1" ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

# https://discourse.nixos.org/t/using-older-revisions-of-nvidia-drivers/28645/3
# https://discourse.nixos.org/t/overriding-a-package-version-without-building-the-old-version/10696/2
#   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs(old: let 
#     version = "535.129.03";
#     src = fetchurl {
#       url = "https://download.nvidia.com/XFree86/Linux-x86_64/${version}/NVIDIA-Linux-x86_64-${version}.run";
#       sha256 = "";
#     };
#   );

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # Lenovo Y50-70 has GeForce GTX 860M so 470 driver
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  hardware.nvidia.prime = {
    offload = {
	enable = true;
	enableOffloadCmd = true;
    };
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };


}

{
  # Spice VDA for clipboard sharing, copy/paste to VM consoles
  services.spice-vdagentd.enable = true;

  # 2023/11/01 gnome flashback broke in VMs, use Mate for now
  services.xserver.desktopManager.mate.enable = true;

  # shared with host OS
  fileSystems."/home/cpayne/shared" =
    { device = "shared";
      fsType = "virtiofs";
    };
}

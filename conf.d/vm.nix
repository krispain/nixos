{
  # Spice VDA for clipboard sharing, copy/paste to VM consoles
  services.spice-vdagentd.enable = true;

  # shared with host OS
  fileSystems."/home/cpayne/shared" =
    { device = "shared";
      fsType = "virtiofs";
    };
}

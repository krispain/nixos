{
  # Spice VDA for clipboard sharing, copy/paste to VM consoles
  services.spice-vdagentd.enable = true;

  # shared with host OS
  # for this to work nixos on nixos, need to add this to the filesystem XML
  #   <binary path="/run/current-system/sw/bin/virtiofsd"/>
  fileSystems."/home/cpayne/shared" =
    { device = "shared";
      fsType = "virtiofs";
    };
}

{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  environment.systemPackages = with pkgs; [
     virt-manager
     dnsmasq
     spice-gtk
  ];
  
  # for Windows VM
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  users.users.cpayne.extraGroups = [ "tss" ];  # tss group has access to TPM devices
# need to run these 2 to get networking running and on by default
# virsh net-autostart default
# virsh net-start default

}

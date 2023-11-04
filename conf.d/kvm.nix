{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  environment.systemPackages = with pkgs; [
     virt-manager
     dnsmasq
  ];

# need to run these 2 to get networking running and on by default
# virsh net-autostart default
# virsh net-start default

}

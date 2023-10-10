{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  environment.systemPackages = with pkgs; [
     virt-manager
  ];

}

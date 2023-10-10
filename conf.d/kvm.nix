{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     virt-manager
     virt-manager-qt
  ];

}

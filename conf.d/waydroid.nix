{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;

  environment.systemPackages = [
    cage
  ];

}

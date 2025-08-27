{ pkgs, ... }:
{
  environment.systemPackages = [
    clamav
  ];
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

}

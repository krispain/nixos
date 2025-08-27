{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clamav
  ];
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;

    daemon.settings = {
        OnAccessPrevention = true;
        OnAccessIncludePath = "/home/cpayne/Downloads";
    };
  };

}

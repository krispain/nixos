{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clamav
  ];
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;

    daemon.settings = {
        ScanOnAccess = yes;
        OnAccessIncludePath = "/home/cpayne/Downloads";
	OnAccessExcludeUname = "clamav";
        OnAccessPrevention = yes;
        OnAccessDisableDDD = yes;
    };
  };

}

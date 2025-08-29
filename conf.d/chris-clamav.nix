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
        OnAccessPrevention = true;
	OnAccessExcludeUname = "clamav";
        OnAccessPrevention = yes;
        OnAccessDisableDDD = yes;
    };
  };

}

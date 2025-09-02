{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clamav
  ];
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;

    daemon.settings = {
        OnAccessIncludePath = "/home/cpayne/Downloads";
	OnAccessExcludeUname = "clamav";
        OnAccessPrevention = true;
    };
  };
    systemd.services.clamonacc = {
        wantedBy = [ "multi-user.target" ];
        after = [ "clamav-daemom.target" ];
        description = "Start the clamav on access scanner.";
        serviceConfig = {
            Type = "notify";
            User = "root";
            ExecStart = ''/run/current-system/sw/bin/clamonacc''; 
            ExecStop = ''killall -2 clamonacc'';
        };
   };


}

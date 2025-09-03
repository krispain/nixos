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
          ExecStart = ''${pkgs.clamav}/bin/clamonacc -v''; 
          ExecStop = ''killall -2 clamonacc'';
      };
   };
   users.users.cpayne.createHome = true;
   users.users.cpayne.homeMode = "755";

}

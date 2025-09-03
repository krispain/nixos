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
      after = [ "clamav-daemon.service" ];
      requires = [ "clamav-daemon.service" ];
      description = "The clamav on access scanner.";
      serviceConfig = {
          Type = "forking";
          User = "root";
	  ExecPreStart = ''sleep 5'';
          ExecStart = ''${pkgs.clamav}/bin/clamonacc''; 
          SocketType = "unix";
          SocketPath = "/run/clamav/clamd.ctl";
      };
   };
   users.users.cpayne.createHome = true;
   users.users.cpayne.homeMode = "755";

}

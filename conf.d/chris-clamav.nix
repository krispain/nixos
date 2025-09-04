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
	TCPSocket = "3310";
	TCPAddr = "localhost";
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
          ExecStart = ''${pkgs.clamav}/bin/clamonacc''; 
          SocketType = "tcp";
          SocketPath = "127.0.0.1:3310";
      };
   };
   users.users.cpayne.createHome = true;
   users.users.cpayne.homeMode = "755";

}

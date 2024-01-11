{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
     docker-compose
     tigervnc	# for VNC to containers if needed
  ];

  users.extraGroups.docker.members = [ "cpayne" ];

}

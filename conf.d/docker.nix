{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
     docker-compose
  ];

  users.extraGroups.docker.members = [ "cpayne" ];

}

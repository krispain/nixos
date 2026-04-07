{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     distrobox
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; 
    };
  };
  
  users.users.cpayne = {
    extraGroups = [
      "podman"
    ];
  };

}

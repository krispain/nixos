{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     home-assistant
  ];

}

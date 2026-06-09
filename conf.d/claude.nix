{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     claude-code
     python313Packages.pip
  ];

}

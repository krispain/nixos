{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];

  programs.kdeconnect.enable = true;

}

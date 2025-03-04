# /etc/nixos/configuration.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     droidcam
     v4l-utils
  ];

  # Install OBS Studio with droidcam-obs
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      droidcam-obs
    ];
    enableVirtualCamera = true;
  };
}

# /etc/nixos/configuration.nix
{ pkgs, ... }:

{
  # Install OBS Studio with droidcam-obs
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
    enableVirtualCamera = true;
  };
}

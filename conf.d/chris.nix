{ config, lib, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the Gnome Flashback Desktop Environment.
  services.xserver.desktopManager.gnome.flashback.enableMetacity = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  environment.systemPackages = with pkgs; [
     # browsers
     chromium
     brave

     # CLI tools
     mate.mate-terminal
     neofetch
     htop
     ncdu
     git
     et

     # GUI tools
     slack
     bitwarden
     signal-desktop
     authy

     # Office
     libreoffice

     # Images/sound
     gimp
     shotwell
     audacity
     sox
     ffmpeg

     # so we can build our own flatpak, specifically wwphone
     flatpak-builder

     # Make gnome great again
     gnome.gnome-tweaks

    # Security
     protonvpn-cli
     qbittorrent

  ];

  # set default editor to neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        syntax on
      '';
    };
  };

  # flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  }; 

}

{ config, lib, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Gnome Flashback Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.flashback.enableMetacity = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
     parted
     zip
     unzip
     file
     wget

     # GUI tools
     slack
     bitwarden
     signal-desktop
     authy
     telegram-desktop
     nextcloud-client

     # Office
     libreoffice

     # Images/sound
     gimp-with-plugins
     shotwell
     mate.mate-utils
     mate.eom
     audacity
     sox
     ffmpeg
     vlc

     # so we can build our own flatpak, specifically wwphone
     flatpak-builder

     # Make gnome great again
     gnome.gnome-tweaks
     gnome.gnome-applets
     networkmanagerapplet

    # Security
     protonvpn-cli
     qbittorrent
     wireguard-tools

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

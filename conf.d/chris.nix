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

  # printer discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # enables support for SANE scanners
  hardware.sane.enable = true; 
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

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

  };

  environment.systemPackages = with pkgs; [
     # browsers
     chromium
     brave
     firefox-esr-115-unwrapped

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
     traceroute
     android-tools
     (lib.hiPrio pkgs.eternal-terminal) # higher priority than egg timer 

     # GUI tools
     slack
     bitwarden
     signal-desktop
     authy
     telegram-desktop
     nextcloud-client
     meld
     adoptopenjdk-icedtea-web
     openvpn

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
     yt-dlp

     # so we can build our own flatpak, specifically wwphone
     flatpak-builder

     # Make gnome great again
     gnome.gnome-tweaks
     gnome.gnome-applets
     networkmanagerapplet
     gst_all_1.gstreamer
     gst_all_1.gst-plugins-base
     gst_all_1.gst-plugins-good
     gst_all_1.gstreamer.dev
     gst_all_1.gst-plugins-bad
     gst_all_1.gst-plugins-ugly
     gst_all_1.gst-libav

    # Security
     protonvpn-cli
     qbittorrent
     wireguard-tools

    # zram for "swap"
    pkgs.zram-generator

  ];

  # prioritize eternal-terminal et over the egg-timer one
  # packageOverrides = pkgs: {
  #    eternal-terminal = pkgs.eternal-terminal.overrideAttrs (attrs: {
  #      meta.priority = pkgs.et.meta.priority +1;
  #    });
  # };

  # set default editor to neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        syntax on
	set mouse=r
      '';
    };
  };

  # flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  }; 

  # enable zram swap
  zramSwap.enable = true;

}

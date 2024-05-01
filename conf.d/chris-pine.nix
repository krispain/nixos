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
  # services.xserver.desktopManager.gnome.flashback.enableMetacity = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # printer discovery, custom from https://nixos.wiki/wiki/Printing "Troubleshooting"
  # services.avahi.nssmdns = false; # Use the settings from below
    # settings from avahi-daemon.nix where mdns is replaced with mdns4
  system.nssModules = pkgs.lib.optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  system.nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
    (mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
    (mkAfter [ "mdns4" ]) # after dns
  ]);

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

     # CLI tools
     mate.mate-terminal
     neofetch
     htop
     ncdu
     git
     parted
     zip
     unzip
     file
     wget
     traceroute
     (lib.hiPrio pkgs.eternal-terminal) # higher priority than egg timer 
     mosh
     fwupd
     nvd
     bintools
     whois
     dig
     cron
     bc
     nmap

     # GUI tools
     nextcloud-client
     meld
     openvpn
     linphone
     mate.atril

     # Images/sound
     gimp-with-plugins
     mate.mate-utils
     mate.eom
     audacity
     sox
     ffmpeg
     vlc
     yt-dlp

     # so we can build our own flatpak, specifically wwphone
     flatpak-builder

    # Security
     wireguard-tools

    # zram for "swap"
    pkgs.zram-generator

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
	set mouse=r
      '';
    };
  };

  # flatpak
  services.flatpak.enable = true;

  # fwupd
  services.fwupd.enable = true;

  # cron
  services.cron.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  }; 

  # enable zram swap
  zramSwap.enable = true;

}

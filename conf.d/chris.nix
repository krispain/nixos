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

  # printer discovery, custom from https://nixos.wiki/wiki/Printing "Troubleshooting"
  services.avahi.nssmdns = false; # Use the settings from below
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
     mosh
     fwupd
     nvd
     bintools
     rclone
     whois
     dig

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
     glxinfo

     # Office
     libreoffice
     hplipWithPlugin

     # Images/sound
     gimp-with-plugins
     shotwell
     mate.mate-utils
     mate.eom
     audacity
     sox
     ffmpeg
     vlc
     mplayer
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
     # gst_all_1.gst-vaapi

    # Security
     protonvpn-cli
     qbittorrent
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  }; 

  # enable zram swap
  zramSwap.enable = true;

  # gstreamer path setup
  # https://github.com/NixOS/nixpkgs/issues/207641
  environment.sessionVariables = { GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
				pkgs.gst_all_1.gst-plugins-base
				pkgs.pkgsi686Linux.gst_all_1.gst-plugins-base
				pkgs.gst_all_1.gst-plugins-good
				pkgs.pkgsi686Linux.gst_all_1.gst-plugins-good
				pkgs.gst_all_1.gst-plugins-bad
				pkgs.pkgsi686Linux.gst_all_1.gst-plugins-bad
				pkgs.gst_all_1.gst-plugins-ugly
				pkgs.pkgsi686Linux.gst_all_1.gst-plugins-ugly
				pkgs.gst_all_1.gst-libav
				pkgs.pkgsi686Linux.gst_all_1.gst-libav
				pkgs.gst_all_1.gst-vaapi
				pkgs.pkgsi686Linux.gst_all_1.gst-vaapi
			];
  };
}

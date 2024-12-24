{ config, lib, pkgs, ... }:

  let
    unstable = import <nixos-unstable> {};
  in

{
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # enables support for SANE scanners
  hardware.sane.enable = true; 
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  # Enable sound with pipewire.
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
     unstable.brave
     firefox-esr-unwrapped

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
     cron
     bc
     nmap

     # GUI tools
     slack
     bitwarden
     signal-desktop
     telegram-desktop
     nextcloud-client
     meld
     adoptopenjdk-icedtea-web
     openvpn
     glxinfo
     linphone
     mate.atril

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
     gnome-tweaks
     gnome-applets
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
     unstable.protonvpn-gui
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
 
  # cron
  services.cron.enable = true;

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

{ config, lib, pkgs, ... }:

  # use unstable protonvpn-gui
  #
  # Also need to manually add the channel as root:
  # nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # nix-channel --update
  let
    unstable = import <nixos-unstable> {};
  in 
  {

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Gnome Flashback Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.gnome.flashback.enableMetacity = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "qbittorrent-4.6.4"
  ];

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
     firefox-esr-unwrapped

     # CLI tools
     mate.mate-terminal
     neofetch
     htop
     gtop
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
     nextcloud-client
     meld
     adoptopenjdk-icedtea-web
     openvpn
     glxinfo
     linphone
     mate.atril
     gparted
     lsof

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
     ffmpeg-normalize
     vlc
     yt-dlp
     id3v2
     cdrkit
     lame
     id3lib
     mp3gain
     simple-scan

     # so we can build our own flatpak, specifically wwphone
     flatpak-builder

     # Make gnome great again
     gnome-tweaks
     gnome-applets
     gnomeExtensions.system-monitor
     networkmanagerapplet
     gst_all_1.gstreamer
     gst_all_1.gst-plugins-base
     gst_all_1.gst-plugins-good
     gst_all_1.gstreamer.dev
     gst_all_1.gst-plugins-bad
     gst_all_1.gst-plugins-ugly
     gst_all_1.gst-libav
     # gst_all_1.gst-vaapi

     # cinnamon
     libgtop

    # Security
     unstable.protonvpn-gui
     wireguard-tools
     qbittorrent

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

  # Add users bin to path
  environment.localBinInPath = true;

  # sudo doesn't need a password to burn cds
  security.sudo.extraRules= [
    {  users = [ "cpayne" ];
      commands = [
         { command = "/run/current-system/sw/bin/wodim" ;
           options= [ "NOPASSWD" ]; 
        }
      ];
    }
  ];
}

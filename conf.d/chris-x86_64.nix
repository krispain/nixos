{ config, lib, pkgs, ... }:

  let
    unstable = import <nixos-unstable> {};
  in

{
  environment.systemPackages = with pkgs; [
     unstable.brave
     slack
     bitwarden
     signal-desktop
     mplayer
     gnomeExtensions.system-monitor
     gtop
     gobject-introspection
     printrun
  ];

  # run the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

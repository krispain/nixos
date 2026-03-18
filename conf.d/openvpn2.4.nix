{ pkgs, ... }:

let
  # URL to the source package
  srcUrl = "https://build.openvpn.net/downloads/releases/openvpn-2.4.12.tar.gz";

  # Derive a package from the source
  openvpn = pkgs.stdenv.mkDerivation {
    name = "openvpn";
    version = "2.4.12";
    src = pkgs.fetchurl {
      url = srcUrl;
      sha256 = "e7734c97501c44a2a8df69a243dde26e";
    };

    configureFlags = [
      "--prefix=${pkgs.stdenv.lib.makeStorePath "${pkgs.stdenv.hostName}"}"
    ];

    buildInputs = [];

    meta = {
      description = "OpenVPN";
      homepage = "https://openvpn.net/";
      license = pkgs.lib.licenses.gpl3;
    };
  };

in
  openvpn

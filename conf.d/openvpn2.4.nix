{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Build the OpenVPN package
    (pkgs.stdenv.mkDerivation rec {
      pname = "openvpn";
      version = "2.4.12";

      src = pkgs.fetchurl {
        url = "https://build.openvpn.net/downloads/releases/openvpn-2.4.12.tar.gz";
        sha256 = ""
    };
  }
}

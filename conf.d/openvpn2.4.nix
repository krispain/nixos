{ config, pkgs, ... }:

let
  # Fetch and unpack the OpenVPN source tarball
  openvpnSource = builtins.fetchTarball {
    url = "https://build.openvpn.net/downloads/releases/openvpn-2.4.12.tar.gz";
    sha256 = "7571c7663698f9ec25d5721aa7addafaba1107e2c9770d1bacf805a15a565d53";
  };

  # Build the OpenVPN package
  openvpn = pkgs.stdenv.mkDerivation {
    name = "openvpn-2.4.12";
    src = openvpnSource;

    buildInputs = with pkgs; [ openssl curl ];

    configurePhase = ''
      ./configure --prefix=$out
    '';

    buildPhase = "make";

    installPhase = ''
      make install
    '';
  };
in
{
  # Define the package in your system configuration
  environment.systemPackages = [ openvpn ];
}

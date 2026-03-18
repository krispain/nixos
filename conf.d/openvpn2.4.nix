{ config, pkgs, ... }:

let
  # Fetch and unpack the OpenVPN source tarball
  openvpnSource = builtins.fetchTarball {
    url = "https://build.openvpn.net/downloads/releases/openvpn-2.4.12.tar.gz";
    sha256 = "sha256-4pXF38eL30PCNKtaZeWtT3H7JGuSKTPeeAmdkM4AGdQ=";
  };

  # Build the OpenVPN package
  openvpn = pkgs.stdenv.mkDerivation {
    name = "openvpn-2.4.12";
    src = openvpnSource;

    buildInputs = with pkgs; [ openssl curl lz4 net-tools lzo openpam ];
 
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

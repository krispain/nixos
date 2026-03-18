{
  {
    stdenv,
    fetchzip,
  }:

  stdenv.mkDerivation {
    pname = "openvpn24";
    version = "2.4.12";
   
    src = fetchzip {
      url = "https://build.openvpn.net/downloads/releases/openvpn-2.4.12.tar.gz";
      sha256 = "";
    };
  }
}

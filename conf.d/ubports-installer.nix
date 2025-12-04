{ lib, appimageTools, fetchurl, makeDesktopItem }:

let
  pname = "ubports-installer";

  icon = ./ubports-mascot.jpg;

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      inherit icon;
      desktopName = "Ubuntu Touch Installer";
      genericName = "GUI for installing Ubuntu Touch";
      exec = "@out@/bin/ubports-installer";
      comment = "GUI for installing Ubuntu Touch";
      categories = [ "System" ];
      startupNotify = false;
      keywords = [ "system" "os" "network" "ubuntu" "touch" "mobile" ];
    })
  ];

in
appimageTools.wrapType2 rec {
  inherit pname;
  version = "0.9.8-beta";

  src = fetchurl {
    url = "https://github.com/ubports/ubports-installer/releases/download/${version}/ubports-installer_${version}_linux_x86_64.AppImage";
    hash = "sha256-oUQ4AaRiUMeklyI4xzH+krXyedqpLiA9obo5uO8JJak=";
  };

  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}
  '' + lib.concatMapStringsSep "\n "
    (e: ''
      install -Dm444 -t $out/share/applications ${e}/share/applications/*.desktop
    '')
    desktopItems
  + ''
    install -Dm444 ${icon} $out/share/icons/apps/${pname}.jpg;

    for f in $out/share/applications/*.desktop; do
      substituteInPlace $f --subst-var out
    done
  '';

  meta = with lib; {
    description = "Ubuntu Touch installer";
    license = licenses.free;
  };
}

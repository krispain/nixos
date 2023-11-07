{ pkgs, ... }:
{
# setup the routing for the nine wireguard VPNs
  services.networkd-dispatcher = {
    enable = true;
    rules."route-wg-vpn" = {
      onState = ["routable" "off"];
      script = ''
#!${pkgs.runtimeShell}

case $AdministrativeState in
  configured)
    if ip link show dev wg_nine &>> /dev/null; then
      ip route flush table wg_nine || true
      ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 178.209.34.137 via
    elif ip link show dev nine_es34 &>> /dev/null; then
      ip route flush table nine_es34 || true
      ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 5.148.185.104 via
    fi
  ;;
  *)
   ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route del 178.209.34.137 via
   ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route del 5.148.185.104 via
  ;;
esac
      '';
    };
  };
}

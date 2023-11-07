{ pkgs, ... }:
{
# setup the routing for the nine wireguard VPNs
  services.networkd-dispatcher = {
    enable = true;
    rules."route-wg-vpn" = {
      onState = ["routable" "off"];
      script = ''
#!${pkgs.runtimeShell}

case $OperationalState in
  routable)
    case $IFACE in
      wg_nine)
        if ip link show dev $IFACE &>> /dev/null; then
          ip route flush table $IFACE || true
          ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 178.209.34.137 via
	fi
      ;;
      wg_nine34)
        if ip link show dev $IFACE &>> /dev/null; then
          ip route flush table $IFACE || true
          ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 5.148.185.104 via
	fi
      ;;
      *)
        :
      ;;
    esac
  ;;
  off)
    case $IFACE in
      wg_nine)
        ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route del 178.209.34.137 via
        ;;
      wg_nine34)
        ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route del 5.148.185.104 via
      ;;
      *)
        :
      ;;
    esac
  ;;
  *)
    :
  ;;
esac
      '';
    };
  };
}

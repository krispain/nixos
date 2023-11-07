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
    if ip link show dev wg_nine &>> /dev/null; then
      ip route flush table wg_nine || true
      ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 178.209.34.137 via
    fi
    elsif ip link show dev wg_nine34 &>> /dev/null; then
      ip route flush table wg_nine34 || true
      ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 5.148.185.104 via
    fi
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

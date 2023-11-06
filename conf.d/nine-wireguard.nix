{ pkgs, ... }:
{
# setup the routing for the nine wireguard VPNs
  services.networkd-dispatcher = {
    enable = true;
    rules."route-wg-vpn" = {
      onState = ["routable" "off"];
      script = ''
        #!${pkgs.runtimeShell}

        case $2 in
          up)
            if ip link show dev $1 &>> /dev/null; then
              ip route flush table $1 || true
	      case $1 in
	        wg_nine)
                  ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 178.209.34.137 via
		  ;;
		wg_nine34)
                  ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add 5.148.185.104 via
		  ;;
                *)
                  :
                ;;
	      esac
            fi
          ;;
          down)
            case $1 in
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

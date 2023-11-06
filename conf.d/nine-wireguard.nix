{
# setup the routing for the nine wireguard VPNs
  services.networkd-dispatcher = {
    enable = true;
    rules."route-wg-vpn" = {
      onState = ["routable" "off"];
      script = ''
        #!${pkgs.runtimeShell}
        declare -A IF_VPN_IP
	IF_VPN_IP=(
	[wg_nine]="178.209.34.137"
	[wg_nine34]="5.148.185.104"
)

        case $2 in
          up)
            for ifdev in "wg_nine wg_nine34"; do
              if ip link show dev "${ifdev}" &>> /dev/null; then
                ip route flush table "${ifdev}" || true
                ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route add "${IF_VPN_IP[$ifdev]}" via
              fi
            done
          ;;
          down)
            case $1 in
              wg_nine | wg_nine34)
	        ip route|grep default | sed -e 's/.*via \(.*\) dev.*/\1/' | xargs -L1 ip route del "${IF_VPN_IP[$ifdev]}" via
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
      ''
    };
  };
};

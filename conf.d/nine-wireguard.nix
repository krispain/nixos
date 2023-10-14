{
# setup the routing for the nine wireguard VPNs
  services.networkd-dispatcher = {
    enable = true;
    rules."route-wg-vpn" = {
      onState = ["routable" "off"];
      script = ''
        #!${pkgs.runtimeShell}
        set -o errexit
        set -o pipefail
        
        declare -A IF_IDS
        IF_IDS=(
          [wg_nine]=25910
          [wg_nine34]=25911
        )
        
        case $2 in
          up)
            for ifdev in "${!IF_IDS[@]}"; do
              if ip link show dev "${ifdev}" &>> /dev/null; then
                ip route flush table "${IF_IDS[$ifdev]}" || true
                ip -4 route show | grep default | sed -E "s/$/ table ${IF_IDS[$ifdev]}/" | xargs -L1 ip route add
                ip rule show priority "${IF_IDS[$ifdev]}" | grep -q fwmark || ip rule add from all fwmark "${IF_IDS[$ifdev]}" table "${IF_IDS[$ifdev]}" priority "${IF_IDS[$ifdev]}"
              fi
            done
          ;;
          down)
            case $1 in
              wg_nine | wg_nine34)
                ip rule delete priority "${IF_IDS[$1]}" || true
                ip route flush table "${IF_IDS[$1]}"
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

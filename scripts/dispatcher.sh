#!${pkgs.runtimeShell}

set -o errexit
set -o pipefail

IP="/run/current-system/sw/bin/ip"
declare -A IF_IDS
IF_IDS=(
  [wg_nine]=25910
  [wg_nine34]=25911
)

case $2 in
  up)
    for ifdev in "${!IF_IDS[@]}"; do
      if ${IP} link show dev "${ifdev}" &>> /dev/null; then
        ${IP} route flush table "${IF_IDS[$ifdev]}" || true
        ${IP} -4 route show | grep default | sed -E "s/$/ table ${IF_IDS[$ifdev]}/" | xargs -L1 ${IP} route add
        ${IP} rule show priority "${IF_IDS[$ifdev]}" | grep -q fwmark || ${IP} rule add from all fwmark "${IF_IDS[$ifdev]}" table "${IF_IDS[$ifdev]}" priority "${IF_IDS[$ifdev]}"
      fi
    done
  ;;
  down)
    case $1 in
      wg_nine | wg_nine34)
        ${IP} rule delete priority "${IF_IDS[$1]}" || true
        ${IP} route flush table "${IF_IDS[$1]}"
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

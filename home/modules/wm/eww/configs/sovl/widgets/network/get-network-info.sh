#! /usr/bin/env nix-shell
#! nix-shell -i bash -p networkmanager jc jq
# shellcheck shell=bash
# vim: ft=sh

get_connection_info() {
  nmcli device show \
    | jc --nmcli \
    | jq -c -M '[
            (. | map(select([.type] | inside(["ethernet", "wifi"]))) | .[0]),
            (.[] | select(.type == "wireguard"))
          ] as [$default, $wg] | {"default": $default, "wg": $wg}'
}

get_connection_info
nmcli monitor | while read -r _; do
  get_connection_info
done

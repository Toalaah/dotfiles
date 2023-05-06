#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq bspwm
# shellcheck shell=bash
# vim: ft=sh

workspaces() {
  bspc query -T -m | jq -c -M '.focusedDesktopId as $focusedDesktop | .desktops | map(. + {focused: (.id == $focusedDesktop), occupied: (.focusedNodeId != 0)})'
}

workspaces
bspc subscribe desktop node | while read -r _; do
  workspaces
done

#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq xtitle
# shellcheck shell=bash
# vim: ft=sh

MAX_LENGTH="${MAX_LENGTH:-0}"
FMT_STRING='{"name": "%s", "id": %u }\n'

windows() {
  focused_win_id=$(xtitle -f "%u\n" $(bspc query -N -n .focused -d focused))
  # need to perform additional manipulation of escaped characters (actually, also partially undo escaping) on top of what xtitle escapes in order to satisfy jq
  xtitle -f "$FMT_STRING" -e -t "$MAX_LENGTH" $(bspc query -N -n .window -d focused) \
    | sed -e "s/\\\\'/'/g" -e 's/\\\\/\\\\\\\\/g' \
    | jq --argjson focused_win_id "$focused_win_id" -srcM \
    '. | map(. + {focused: (.id == $focused_win_id)}) | map(select(.id != 0))'
}

windows
xtitle -s | while read -r _ ; do
  windows
done

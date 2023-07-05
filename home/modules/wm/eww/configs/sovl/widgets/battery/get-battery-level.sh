#! /usr/bin/env nix-shell
#! nix-shell -i bash -p eww jq
# shellcheck shell=bash
# vim: ft=sh

info=$(eww get EWW_BATTERY | jq '.[keys[0]]')
if [ -z "$info" ]; then
  echo 'null'
else
  echo $info
fi

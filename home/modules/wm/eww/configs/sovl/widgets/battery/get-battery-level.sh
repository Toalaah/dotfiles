#! /usr/bin/env nix-shell
#! nix-shell -i bash -p acpi jc jq
# shellcheck shell=bash
# vim: ft=sh

info=$(acpi | jc --acpi | jq '.[0]')
# filter power supplies (which always give charge of 0). This only breaks when the
# laptop battery is empty, but this would also imply that the laptop (and thus
# this script) is dead
if [ $(jq '.charge_percent > 0 and .charge_percent != null' <<< $info) == "true" ]; then
  echo $info
else
  echo 'null'
fi

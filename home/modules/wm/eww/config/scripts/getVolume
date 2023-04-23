#! /usr/bin/env cached-nix-shell
#! nix-shell -i bash -p pulseaudio pamixer
# shellcheck shell=bash
# vim: ft=sh

volume() {
  printf '{ "volume": "%s", "muted": %s }\n' $(pamixer --get-volume) $(pamixer --get-mute)
}

default_sink=$(pamixer --get-default-sink | sed -n 2p | cut -d' ' -f1)
volume
pactl subscribe | grep --line-buffered "sink #$default_sink" | while read -r _; do
  volume
done

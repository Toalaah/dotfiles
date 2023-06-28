#! /usr/bin/env nix-shell
#! nix-shell -i bash -p acpi jc jq
# shellcheck shell=bash
# vim: ft=sh

acpi | jc --acpi | jq -r '.[0]'

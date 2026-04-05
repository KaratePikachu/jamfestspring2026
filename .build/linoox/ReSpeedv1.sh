#!/bin/sh
printf '\033c\033]0;%s\a' JamfestSpring2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ReSpeedv1.x86_64" "$@"

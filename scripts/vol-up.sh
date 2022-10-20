#!/bin/bash

/usr/bin/amixer -qM set Master 10%+ unmute
#pactl set-sink-volume @DEFAULT_SINK@ +5%
bash ~/.dwm/scripts/dwm-status-refresh.sh

#!/bin/bash

/usr/bin/amixer -D pulse set Master 1+ toggle
bash ~/.dwm/scripts/dwm-status-refresh.sh

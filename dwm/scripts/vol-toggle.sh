#!/bin/bash

/usr/bin/amixer -D pulse set Master 1+ toggle
bash ~/suckless/dwm/scripts/dwm-status-refresh.sh

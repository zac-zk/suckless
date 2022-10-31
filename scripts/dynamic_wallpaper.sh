#!/bin/bash

mkfifo /tmp/wallpaper; xwinwrap -fs -nf -fdt -ov -- mplayer -nosound -shuffle -slave -input file=/tmp/wallpaper -loop 0 -wid WID -nolirc `find ~/data/Pictures/wallpaper/Dynamic -type f`

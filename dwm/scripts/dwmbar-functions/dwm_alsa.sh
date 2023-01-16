#!/bin/sh

# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
    VOL=$(amixer -M get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    MUTE=$(amixer get Master | tail -n1 | sed -r "s/.*\[(on|off)\]$/\1/")
    if [ "$MUTE" = "on" ]; then
        if [ "$VOL" -eq 0 ]; then
            printf "ﱝ"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "奄 %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "奔 %s%%" "$VOL"
        else
            printf "墳 %s%%" "$VOL"
        fi
    else
        printf "婢"
	fi
}

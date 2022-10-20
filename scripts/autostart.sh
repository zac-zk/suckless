#!/bin/bash

#bash -c '~/suckless/scripts/dwm-status.sh &'
bash -c '~/suckless/scripts/tap-to-click.sh &'
bash -c '~/suckless/scripts/inverse-scroll.sh &'
bash -c '~/suckless/scripts/wp-autochange.sh &'
#bash -c  '~/suckless/scripts/dynamic_wallpaper.sh &'

arr=("pnmixer" "clash" "dunst"  "slstatus" "copyq" "nm-applet" "picom --config ~/.config/picom.conf" "redshift" "tlp" "xautolock -time 10 -locker slock")

for value in ${arr[@]}; do
    isExist=$(ps -ef | grep $value | grep -v grep | wc -l)
    if [ $isExist = 0 ]; then
        exec $value &
    fi
done

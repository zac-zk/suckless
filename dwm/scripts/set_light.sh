#! /bin/bash

case $1 in
    up) xbacklight -inc 10 ;;
    down) xbacklight -dec 10 ;;
esac

echo $DWM

bash $DWM/statusbar/statusbar.sh update light
bash $DWM/statusbar/packages/light.sh notify 

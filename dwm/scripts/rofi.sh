#!/usr/bin/bash

# 打印菜单
call_menu() {
    [ "$(ps aux | grep picom | grep -v 'grep\|rofi\|nvim')" ] && echo ' close picom' || echo ' open picom'
    echo ' update statusbar'
}

# 执行菜单
execute_menu() {
    case $1 in
        ' open picom')
            coproc (picom --config ~/suckless/dwm/scripts/picom.conf -b)
            ;;
        ' close picom')
            killall picom
            ;;
        ' update statusbar')
            coproc ($DWM/statusbar/statusbar.sh updateall > /dev/null 2>&1)
            ;;
    esac
}

execute_menu "$(call_menu | rofi -dmenu -p "")"

#! /bin/bash
# 亮度
# 需要安装xorg-backlight

tempfile=$(cd $(dirname $0);cd ..;pwd)/temp

this=_light
color="^c#ffffff^^b#3333330x99^"
signal=$(echo "^s$this^" | sed 's/_//')

get_by_xbacklight() {
    [ ! "$(command -v xbacklight)" ] && echo command not found: xbacklight && return
    light_text=$(xbacklight -get)
}

update() {
    get_by_xbacklight
    [ -z $light_text ] && light_text=0
    if   [ "$light_text" -ge 100 ]; then light_icon="󰛨";
    elif [ "$light_text" -ge 90 ]; then light_icon="󱩖";
    elif [ "$light_text" -ge 80 ]; then light_icon="󱩕";
    elif [ "$light_text" -ge 70 ]; then light_icon="󱩔";
    elif [ "$light_text" -ge 60 ]; then light_icon="󱩓";
    elif [ "$light_text" -ge 50 ]; then light_icon="󱩒";
    elif [ "$light_text" -ge 40 ]; then light_icon="󱩑";
    elif [ "$light_text" -ge 30 ]; then light_icon="󱩐";
    elif [ "$light_text" -ge 20 ]; then light_icon="󱩏";
    elif [ "$light_text" -ge 10 ]; then light_icon="󱩎";
    else light_icon="󰌶"; fi

    icon=" $light_icon"
    text=" $light_text% "

    sed -i '/^export '$this'=.*$/d' $tempfile
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$color" "$icon" "$color" "$text" >> $tempfile
}

notify() {
    update
    notify-send -r 9527 -h int:value:$light_text -h string:hlcolor:#dddddd "$light_icon Light"
}

click() {
    case "$1" in
		L) notify ;;
        U) xbacklight -inc 10 ;notify ;;
        D) xbacklight -de 10 ;notify ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac

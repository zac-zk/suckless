#! /bin/bash
# VOL 音量脚本
# 本脚本需要你自行修改音量获取命令
# 例如我使用的是 amixer


tempfile=$(cd $(dirname $0);cd ..;pwd)/temp

this=_vol
icon_color="^c#442266^^b#7879560x88^"
text_color="^c#442266^^b#7879560x99^"
signal=$(echo "^s$this^" | sed 's/_//')

# check
[ ! "$(command -v pactl)" ] && echo command not found: pactl && exit

update() {
    vol_text=$(amixer -M get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    vol_muted=$(amixer get Master | tail -n1 | sed -r "s/.*\[(on|off)\]/\1/")

    if [ ! "$vol_muted" = "on" ];      then vol_text="--"; vol_icon="ﱝ";
    elif [ "$vol_text" -eq 0 ];  then vol_text="00"; vol_icon="";
    elif [ "$vol_text" -lt 30 ]; then vol_icon=""; vol_text=$vol_text;
    elif [ "$vol_text" -le 60 ]; then vol_icon="󰕾";
    else vol_icon=""; fi

    icon=" $vol_icon "
    text=" $vol_text% "

    sed -i '/^export '$this'=.*$/d' $tempfile
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> $tempfile
}

notify() {
    update
    notify-send -r 9527 -h int:value:$vol_text -h string:hlcolor:#dddddd "$vol_icon Volume"
}

click() {
    case "$1" in
        L) notify                                           ;; # 仅通知
        M) pactl set-sink-mute @DEFAULT_SINK@ toggle        ;; # 切换静音
        R) killall pavucontrol || pavucontrol --class=FGN & ;; # 打开pavucontrol
        U) pactl set-sink-volume @DEFAULT_SINK@ +5%; notify ;; # 音量加
        D) pactl set-sink-volume @DEFAULT_SINK@ -5%; notify ;; # 音量减
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
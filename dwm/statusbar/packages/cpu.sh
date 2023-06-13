#! /bin/bash
# CPU 获取CPU使用率和温度的脚本

tempfile=$(cd $(dirname $0);cd ..;pwd)/temp

this=_cpu
color="^c#ffffff^^b#3333330x99^"
# icon_color="^c#bbbbbb^^b#3333330x88^"
# text_color="^c#bbbbbb^^b#3333330x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    cpu_icon="󰻠"
    cpu_text=$(top -bn 1 | grep '^%Cpu' | tr -d 'usy,' | awk '{print $2 }')
    temp_text=$(tlp-stat -t | grep CPU |awk '{print $4}')

    icon=" $cpu_icon"
    text=" $cpu_text% $temp_text°C "

    sed -i '/^export '$this'=.*$/d' $tempfile
    # printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> $tempfile
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$color" "$icon" "$color" "$text" >> $tempfile
}

notify() {
    notify-send "CPU tops" "\n$(ps axch -o cmd:15,%cpu --sort=-%cpu | head)\\n" -r 9527
}

call_htop() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_cpu' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t statusutil_cpu -g 82x25+$((mx - 328))+$((my + 20)) -c FGN -e htop
}

click() {
    case "$1" in
        L) notify ;;
        M) ;;
        R) call_htop ;;
        U) ;;
        D) ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac

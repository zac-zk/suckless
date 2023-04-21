#! /bin/bash
# ICONS 部分特殊的标记图标 这里是我自己用的，你用不上的话去掉就行

tempfile=$(cd $(dirname $0);cd ..;pwd)/temp

this=_icons
color="^c#ffffff^^b#3333330x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    icons=("")

    text=" ${icons[@]} "

    sed -i '/^export '$this'=.*$/d' $tempfile
    printf "export %s='%s%s%s'\n" $this "$signal" "$color" "$text" >> $tempfile
}

notify() {
    texts=""
    [ "$texts" != "" ] && notify-send " Info" "$texts" -r 9527
}

click() {
    case "$1" in
        L) notify; $DWM/scripts/wp-change.sh ;;
        R) $DWM/scripts/rofi.sh ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
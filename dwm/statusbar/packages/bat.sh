#! /bin/bash
# 电池电量
# 需要安装acpi

tempfile=$(cd $(dirname $0);cd ..;pwd)/temp

this=_bat
color="^c#ffffff^^b#3333330x99^"
signal=$(echo "^s$this^" | sed 's/_//')

get_by_acpi() {
    [ ! "$(command -v acpi)" ] && echo command not found: acpi && return
    total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+));
    battery_number=$(acpi -b | wc -l);
    bat_text=$(expr $total_charge / $battery_number);
    if $(acpi -b | grep --quiet Discharging)
    then
        bat_icon="";
    else 
        bat_icon="";
    fi
}

update() {
    get_by_acpi

    icon=" $bat_icon"
    text=" $bat_text% "

    sed -i '/^export '$this'=.*$/d' $tempfile
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$color" "$icon" "$color" "$text" >> $tempfile
}

notify() {
    update
}

click() {
    case "$1" in
        L) notify ;;
        R) killall xfce4-power-manager-settings || xfce4-power-manager-settings & ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac

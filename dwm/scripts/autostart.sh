#! /bin/bash
# DWM自启动脚本 仅作参考

settings() {
	[ $1 ] && sleep $1
	xset -b # 关闭蜂鸣器
}

kill_clients() {
	apps=("picom" "fcitx5" "pcmanfm" "redshift" "copyq" "cfw" "dunst" "nm-applet")
	for app in ${apps[*]}; do
		count=$(ps -ef | grep ${app} | grep -v "grep" | wc -l)
		if [ $count -gt 0 ]; then
		    kill ${app}
		fi
	done
}

start_clients() {
    picom -b
    fcitx5 -d
    cfw &
    dunst &
    nm-applet &
    redshift &
    copyq --start-server
    pcmanfm --daemon-mode
}

daemons() {
	[ $1 ] && sleep $1
	/usr/lib/polkit-kde-authentication-agent-1 & #提权
	xrandr --output eDP-1-1 --primary --auto --output HDMI-0 --mode 2560x1440 --rate 75 --left-of eDP-1-1 --auto
	$DWM/scripts/wp-change.sh                    #开机设定壁纸
	$DWM/statusbar/statusbar.sh cron &           # 开启状态栏定时更新
    start_clients
}

cron() {
	[ $1 ] && sleep $1
	let i=10
	while true; do
		[ $((i % 300)) -eq 0 ] && $DWM/scripts/wp-change.sh # 每300秒更新壁纸
		sleep 10
		let i+=10
	done
}

settings 1 & # 初始化设置项
daemons 3 &
# cron 5 &                                 # 后台程序项

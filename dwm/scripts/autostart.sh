#! /bin/bash
# DWM自启动脚本 仅作参考 

settings() {
    [ $1 ] && sleep $1
    xset -b                                   # 关闭蜂鸣器
}

start_or_not() {
    apps=("picom" "fcitx5" "redshift" "copyq" "cfw" "dunst" "nm-applet" "syncthing")
    for app in ${apps[*]}
    do
        count=`ps -ef |grep ${app} |grep -v "grep" |wc -l`
        if [ $count -eq 0 ]
        then
            ${app} &
        fi
    done
}

daemons() {
    [ $1 ] && sleep $1
    $DWM/statusbar/statusbar.sh cron &   # 开启状态栏定时更新
    $DWM/scripts/wp-change.sh       #开机设定壁纸
    /usr/lib/polkit-kde-authentication-agent-1 & #提权
    start_or_not()
}

cron() {
    [ $1 ] && sleep $1
    let i=10
    while true; do
        [ $((i % 300)) -eq 0 ] && $DWM/scripts/wp-change.sh # 每300秒更新壁纸
        sleep 10; let i+=10
    done
}

settings 1 &                                  # 初始化设置项
daemons 3 &  
# cron 5 &                                 # 后台程序项

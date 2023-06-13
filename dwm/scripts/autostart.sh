#! /bin/bash
# DWM自启动脚本 仅作参考 

settings() {
    [ $1 ] && sleep $1
    xset -b                                   # 关闭蜂鸣器
}

daemons() {
    [ $1 ] && sleep $1
    $DWM/statusbar/statusbar.sh cron &   # 开启状态栏定时更新
    $DWM/scripts/wp-change.sh       #开机设定壁纸
    /usr/lib/polkit-kde-authentication-agent-1 & #提权
    killall fcitx5 ; fcitx5 -d &                    # 开启输入法
    killall picom ; picom --config $DWM/scripts/picom.conf -b
    killall copyq ; copyq &
    killall cfw ; cfw &
    killall nm-applet ; nm-applet &
    killall redshift ; redshift &
    killall dunst ; dunst &
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
cron 5 &                                 # 后台程序项

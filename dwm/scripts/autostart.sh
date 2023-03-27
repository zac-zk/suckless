#! /bin/bash
# DWM自启动脚本 仅作参考 

settings() {
    [ $1 ] && sleep $1
    xset -b                                   # 关闭蜂鸣器
    $DWM/scripts/inverse-scroll.sh      # 触摸板自然滚动
    $DWM/scripts/tap-to-click.sh          # 触摸板点击
}

daemons() {
    [ $1 ] && sleep $1
    $DWM/statusbar/statusbar.sh cron &   # 开启状态栏定时更新
    $DWM/scripts/wp-change.sh       #开机设定壁纸
    xss-lock -- $DWM/scripts/blurlock.sh &       # 开启自动锁屏程序
    kill ibus-daemon ; ibus-daemon -x -d &                    # 开启输入法
    kill picom ; picom -b --config $DWM/scripts/picom.conf &
    kill copyq ; copyq &
    kill cfw ; cfw &
    kill nm-applet ; nm-applet &
    kill redshift ; redshift &
    kill dunst ; dunst -conf $DWM/scripts/config/dunstrc &
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

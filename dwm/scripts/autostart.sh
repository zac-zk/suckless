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
    $DWM/scripts/wp-change.sh
    kill fcitx5 & fcitx5 &                    # 开启输入法
    kill picom & picom -b
    kill copyq & copyq &
    kill cfw & cfw &
    kill nm-applet & nm-applet &
}

settings 1 &                                  # 初始化设置项
daemons 3 &                                   # 后台程序项

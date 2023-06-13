- dwm 下 idea 灰屏

```
paru -S wmname

编辑 ~/.xinitrc ,在启动dwm前加入:

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D
```

- matlab 白屏

```
编辑 ~/.xinitrc ,在启动dwm前加入:
export _JAVA_AWT_WM_NONREPARENTING=1
```

- 解决 wps 不能激活 fcitx5 的问题

```
编辑 /usr/bin 目录下的 wps wpp wpspdf et 在第二行加入
export QT_IM_MODULE="fcitx5"
```

- 触摸板设置

```
paru -S xf86-input-synaptics

编辑/etc/X11/xorg.conf.d/70-synaptics.conf

Section "InputClass"
    Identifier "touchpad"
    Driver "synaptics"
    MatchIsTouchpad "on"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertEdgeScroll" "on"
        Option "VertTwoFingerScroll" "on"
        Option "HorizEdgeScroll" "on"
        Option "HorizTwoFingerScroll" "on"
    Option "VertScrollDelta" "-111"
        Option "HorizScrollDelta" "-111"
    Option "RBCornerButton" "3"
EndSection


```

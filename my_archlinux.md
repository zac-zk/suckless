# 我的Archlinux/suckless系列 配置指南

## 1. 配置软件源

编辑 **/etc/pacman.conf** ,在末尾加上

```
[archlinuxcn]
SigLevel = OPtional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

安装 GPG key

```
sudo pacman -Syu
sudo pacman -S archlinuxcn-keyring
```

## 2.配置suckless系列

系统管理工具相关

```
yay -S acpi acpitool			##电源管理?
yay -S numlockx xorg-xbacklight 
yay -S alsa-utils pulseaudio-alsa	##声卡驱动
yay -S pulseaudio alsamixer pavucontrol		##终端音频管理
yay -S blueman bluez
yay -S mesa lib32-mesa			##intel驱动
yay -S nvidia-lts nvidia-utils nvidia-setting ##nvidia驱动
yay -S mesa-demos				##驱动测试工具
```

dwm:

```
从github下载suckless系列配置
```

编辑快捷键时,可以使用 *xev* 命令查看键位的名称

安装xorg套餐

```
sudo pacman -S xorg-server xorg-xinit
cp /etc/X11/xinit/xinitrc ~/.xinitrc
###删除下面内容
twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
exec xterm -geometry 80x66+0+0 -name login
添加下面内容，然后保存退出。
numlocks &
exec dwm
```

## 3. 配置aur

安装 yay

```
sudo pacman -S yay
yay --aururl="https://aur.tuna.tsinghua.edu.cn" --save
```

## 4.  *fcitx5* 输入法

安装fcitx5相关组件

```
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-gtk fcitx5-qt fcitx5-material-color
```

配置生效(/etc/environment)

```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```

## 5.安装常用字体

```
sudo pacman -S wqy-bitmapfont wqy-microhei  wqy-zenhei adobe-source-code-pro-fonts  adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts adobe-source-han-sans-cn-fonts ttf-monaco ttf-dejavu ttf-hanazono noto-fonts noto-fonts-cjk noto-fonts-emoji nerd-fonts-jetbrains-mono
```

## 6. wps安装和问题解决

```
sudo pacman -S wps-office wps-office-fonts wps-office-mui-zh-cn
```

解决wps不能激活fcitx5的问题

编辑 */usr/bin* 目录下的wps wpp wpspdf et
在第二行加入

```
export QT_IM_MODULE="fcitx5"
```

## 8.常用软件安装

```
yay -S google-chrome filezilla vscodium-bin gimp flameshot goldendict
yay -S namacs 					##看图
yay -S feh picom
yay -S timeshift gparted openssh
yay -S virtualbox linux-lts-header	##header选择根据自己的内核来,这里是lts版本,具体见wiki
## 微信安装见https://github.com/countstarlight/deepin-wine-wechat-arch
yay -S lxappearance				##主题管理
yay -S network-manager-applet	##网络托盘,nm-applet启动
yay -S font-manager				##字体管理
yay -S pcmanfm libmtp gvfs-mtp gvfs-nfs ##pcmanfm文件管理,后面的用于方便挂载硬盘
yay -S vlc					##视频播放
yay -S pnmixer				##音量托盘
yay -S unzip-natspec unarchiver	##前者替代unzip,解决解压中文乱码,后者万能解压
yay -S xarchiver						##图形压缩/解压软件
yay -S jdk11-openjdk jdk8-openjdk

```

## 9.问题解决

### 1.dwm下idea灰屏

安装wmname

```
yay -S wmname
```

编辑 *~/.xinitrc* ,在第二行开始加入:

```
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D
```










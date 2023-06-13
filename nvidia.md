# 机型信息

显卡型号：

- 独显：NVIDIA GeForce GTX 1050 Ti Mobile
- 核显： Intel CoffeeLake-H GT2 [UHD Graphics 630]

内核版本：5.15.26-1-lts

# 安装驱动

笔者使用的是 lts 内核，安装 nvidia-lts，其他内核自行查阅 wiki

```
sudo pacman -S nvidia-lts nvidia-utils nvidia-setting
```

获取 BusID：

```
lspci |egrep "VGA|3D"
------------------------
显示如下信息，关键信息是01：00.0,后面要用：
00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]
01:00.0 3D controller: NVIDIA Corporation GP107M [GeForce GTX 1050 Ti Mobile] (rev a1)
```

最小化配置 xorg.conf:

```
编辑前请先备份
sudo vi /etc/X11/xorg.conf
------------------------
输入如下信息：
Section "Module"
        load "modesetting"
EndSection

Section "Device"
        Identifier "Device0"
        Driver "nvidia"
        VendorName "NVIDIA Corporation"
        BusID "1:0:0"	#即前面获取的BusID
        Option "AllowEmptyInitialConfiguration"
EndSection
```

解决画面撕裂问题：

```
sudo  vi /etc/mkinitcpio.conf
------------------------
修改下述部分:
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
------------------------
sudo vi /etc/default/grub	#电脑需是grub引导
------------------------
修改下述部分:
GRUB_CMDLINE_LINUX_DEFAULT="quiet nvidia-drm.modeset=1"
------------------------
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -p linux-lts	#lts内核使用linux-lts,其他使用linux，配置自动更新
```

配置视频输出：

```
笔者没有使用登录管理器，而是startx启动，使用登录管理器如sddm的自行百度
vi ～/.xinitrc
------------------------
添加下述内容：
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
```

重启,

```
nvidia-smi
------------------------
显示如下信息，驱动安装成功
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 510.54       Driver Version: 510.54       CUDA Version: 11.6     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   43C    P3    N/A /  N/A |    268MiB /  4096MiB |      9%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1024      G   /usr/lib/Xorg                     186MiB |
|    0   N/A  N/A      1134      G   picom                              36MiB |
|    0   N/A  N/A     78386      G   ...417905273326420761,131072       42MiB |
+-----------------------------------------------------------------------------+

```

如果重启黑屏，可能是 nouveau 驱动的原因（也可能是其他的），禁用 nouveau。

```
sudo vi /etc/modprobe.d/nouveau_blacklist.conf
------------------------
添加：
blacklist nouveau
```

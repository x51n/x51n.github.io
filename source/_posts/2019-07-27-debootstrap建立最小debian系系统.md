---
title: debootstrap建立最小debian系系统
categories:
  - 未归类
date: 2019-07-27 15:37:53
tags:
---

## 0x01在宿主机安装debootstrap及挂在磁盘

安装程序

```
sudo apt-get install debootstrap
```

使用cfdisk新建磁盘并标记为可启动

在分区上创建文件系统。例如，在 `/dev/sda6` 分区(以后的例子中，将把它作为 root 分区)建立一个 ext3 格式的文件系统：

```
mkfs.ext4 /dev/sda6
```

初始化并激活交换分区(请把分区号替换成您希望用作 Debian 交换分区的分区号):

```
# mkswap /dev/sda5
# sync
# swapon /dev/sda5
```

把一个分区挂载到 `/mnt/debinst`(这是安装的位置，将来作为您新系统的根(`/`)文件系统)。挂载点的名称是任意的，后面的步骤将会用到。

```
# mkdir /mnt/debinst
# mount /dev/sda6 /mnt/debinst
```

## 0x02 开始安装

使用下面這行 debootstrap 命令，

```
debootstrap --arch amd64 bionic rootfs-debian http://mirrors.tuna.tsinghua.edu.cn/ubuntu/
```

整個 debootstrap 的命令架構如下

```
debootstrap --arch <ARCH> <VERSION> <DIRECTORY>  <MIRROR>
```

- ARCH

  目標系統的 CPU 架構，常用的有 i386、amd64、armel、armhf 等。

- VERSION

  Debian 的版本，你可以使用目前的穩定版本 **wheezy** ，或是 永遠的測試版 **sid** ，當然你也可以選擇更不穩定的 **testing** ，詳細版本名 稱請見 Debian 官網。

- DIRECTORY

  安裝的目錄，這個根據自己的需求設定即可

- MIRROR

  下載 Debian 套件的伺服器，通常選擇該使用者區域內的服務器，



添加`restricted universe multiverse`进源

## 0x03 创建设备文件

此时，/dev/ 只含有非常基本的设备文件。安装的后续步骤可能还需要更多的设备文件，所以我们安装 makedev 软件包，并创建默认的静态设备文件，使用(chroot 以后)

```
apt install makedev
mount none /proc -t proc
cd /dev
MAKEDEV generic
```

## 0x04 分区的挂载

首先新建 /etc/fstab

```
editor /etc/fstab
```



然后根据模板修改

```
# /etc/fstab: static file system information.
#
# file system    mount point   type    options                  dump pass
/dev/XXX         /             ext4    defaults                 0    1
/dev/XXX         /boot         ext4    rw,nosuid,nodev          0    2

/dev/XXX         none          swap    sw                       0    0
proc             /proc         proc    defaults                 0    0

#/dev/fd0         /media/floppy auto    noauto,rw,sync,user,exec 0    0
#/dev/cdrom       /media/cdrom  iso9660 noauto,ro,user,exec      0    0

#/dev/XXX         /tmp          ext4    rw,nosuid,nodev          0    2
#/dev/XXX         /var          ext4    rw,nosuid,nodev          0    2
#/dev/XXX         /usr          ext4    rw,nodev                 0    2
#/dev/XXX         /home         ext4    rw,nosuid,nodev          0    2
```

然后挂载 proc 和sysfs 文件系统
```
mount -t proc proc /proc
mount -t sysfs sysfs /sys
```

## 0x05 网络的配置

需要安装`ifupdown`

```
apt install ifupdown network-manager
```

编辑/etc/network/interfaces，下面是模板：

```
######################################################################
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)
# See the interfaces(5) manpage for information on what options are
# available.
######################################################################

# We always want the loopback interface.
#
auto lo
iface lo inet loopback

# To use dhcp:
#
# auto eth0
# iface eth0 inet dhcp

# An example static IP setup: (broadcast and gateway are optional)
#
# auto eth0
# iface eth0 inet static
#     address 192.168.0.42
#     network 192.168.0.0
#     netmask 255.255.255.0
#     broadcast 192.168.0.255
#     gateway 192.168.0.1
```

然后设定host name
```
echo DebianHostName > /etc/hostname
```

## 0x06 安装内核

```
apt search linux-image
apt install linux-image-arch-etc
```

我习惯上把内核头文件也装上，比如我的就是：

```
apt install linux-image-4.9.0-2-amd64 linux-headers-4.9.0-2-amd64
```

## 0x07 安装引导程序

```
apt install grub-pc
grub-install /dev/sd8
update-grub
```

设定密码

```
passwd
```

------
参考资料

https://hosxy.github.io/2017/05/03/debootstrap%E5%AE%89%E8%A3%85debian/
https://www.debian.org/releases/jessie/i386/apds03.html.zh-cn

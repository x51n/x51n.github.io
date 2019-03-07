---
title: ubuntu16.04+kinetic源码安装kalibr标定工具
categories:
  - slam 
  - 标定
date: 2019-03-05 20:57:41
tags:
  - kalibr
  - slam
  - 标定
---

## 0x00 安装环境

1.　安装ros-kinetic-desktop-full（可以去ros官网去看详细的安装说明，找到国内的源，这样安装比较快）
2.　安装kalibr源码编译所需依赖项：
```bash
sudo apt-get install python-setuptools

sudo apt-get install python-setuptools python-rosinstall ipython libeigen3-dev libboost-all-dev doxygen libopencv-dev

sudo apt-get install libopencv-dev ros-kinetic-vision-opencv ros-kinetic-image-transport-plugins ros-kinetic-cmake-modules python-software-properties software-properties-common libpoco-dev python-matplotlib python-scipy python-git python-pip ipython libtbb-dev libblas-dev liblapack-dev python-catkin-tools libv4l-dev
```

## 0x01 创建工作空间

```bash
mkdir -p ~/kalibr_workspace/src
cd ~/kalibr_workspace
source /opt/ros/indigo/setup.bash		//这里应该是setup.zsh，但是没成功，没有这个文件，待以后调试
catkin init
catkin config --extend /opt/ros/indigo
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
```
## 0x02 开始编译

```bash
cd ~/kalibr_workspace/src
git clone https://github.com/ethz-asl/Kalibr.git
cd ~/kalibr_workspace

//以下开始编译，这里大概需要半个多小时
catkin build -DCMAKE_BUILD_TYPE=Release -j4（根据自己电脑配置调整数值）

source　~/kalibr_workspace/devel/setup.zsh
```
## 0x03 kalibr工具生成标定板

```bash
kalibr_create_target_pdf --type 'apriltag' --nx 6 --ny 6 --tsize 0.08 --tspace 0.3
```

---------------------
作者：ultimate1212 
来源：CSDN 
原文：https://blog.csdn.net/ultimate1212/article/details/83860735 
版权声明：本文为博主原创文章，转载请附上博文链接！
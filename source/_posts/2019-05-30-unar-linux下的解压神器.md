---
title: unar linux下的解压神器
categories:
  - linux
date: 2019-05-30 17:03:59
tags:
  - linux
  - unar
  - lsar
  - 解压
  - 乱码
---

##### 1. 安装

```
sudo apt-get install unar
```

##### 2. 列出压缩内容

```
lsar test.zip
```

##### 3. 解压压缩包

```
unar test.zip
```

##### 4. unar常用选项解释

-o

```
解释：指定解压结果保存的位置 
unar test.zip -o /home/dir/
```

-e

```
解释：指定编码 
unar -e GBK test.zip
```

-p

```
解释：指定解压密码 
unar -p 123456 test.zip
```

##### 5. 解决linux解压压缩包中文文件名乱码问题

```
lsar test.zip

###若发现乱码，可指定压缩包文件名使用的编码格式##
lsar -e GB18030 test.zip

###若能正常列出文件名，可解压###
unar -e GB18030 test.zip
```

##### 注意

unar解压４Ｇ以上文件可能会出错，原因未知
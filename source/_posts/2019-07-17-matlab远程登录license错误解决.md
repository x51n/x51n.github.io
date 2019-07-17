---
title: 远程桌面下启动MATLAB时的License Manager Error -103错误
categories:
  - 未归类
date: 2019-07-17 11:51:36
tags:
---

方法如下：
1. 打开C:\Program Files\MATLAB\R2015b\licenses\license*.lic
2. 在每条记录后添加“TS_OK” 

之后就可以在远程桌面中正常打开matlab。
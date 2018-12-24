---
title: Windows下部署hexo
date: 2018-12-24 11:47:38
tags:
  - hexo
  - windows
---


### 0x00 安装node.js

1. 下载：从官网下载windows版本的node.js安装包（.msi后缀）
   下载地址：
   [https://nodejs.org/zh-cn/download/](https://link.jianshu.com/?t=https://nodejs.org/zh-cn/download/)
2. 安装：双击安装，一直点击下一步即可

### 0x01 安装hexo

在打开的命令窗内输入下面的命令进行安装

```bash
npm install hexo-cli -g
```

安装过后，输入 `hexo -v`，出现下面信息，则表示安装成功

```bash
$ hexo -v
hexo-cli: 1.0.2
os: Windows_NT 6.1.7601 win32 x64
http_parser: 2.7.0
node: 6.10.0
v8: 5.1.281.93
uv: 1.9.1
zlib: 1.2.8
ares: 1.10.1-DEV
icu: 58.2
modules: 48
openssl: 1.0.2k
```

### 0x02 常用命令

#### 初始化blog

```
$ hexo init myblog
```

#### 本地启动博客

```
$ cd myblog
$ hexo server
```


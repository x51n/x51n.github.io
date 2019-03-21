---
title: 脚本备份wordpress
categories:
  - 未归类
date: 2019-03-21 19:23:41
tags:
---

用脚本自动备份wordpress安装文件夹和mysql数据库

```bash
#!/bin/bash
 
backpath=/var/www/backup/
date=`date +%y%m%d`
site='wiki'
BCK_DIR=/var/www/html/mysql_back/
mkdir -p ${BCK_DIR}
/usr/bin/mysqldump --opt -uroot -p密码 wordpress(数据库名) | gzip > ${BCK_DIR}${site}"-"${date}.sql.gz  
tar zcf ${backpath}${site}"-"${date}.tar.gz /var/www/html/
rm -rf ${BCK_DIR}
cadaver https://dav.jianguoyun.com/dav/backup/ <<E
put ${backpath}${site}-${date}.tar.gz
E
```





[**点击这里直接下载脚本**](backup.sh)
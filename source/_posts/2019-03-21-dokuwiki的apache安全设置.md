---
title: dokuwiki的apache安全设置
categories:
  - 未归类
date: 2019-03-21 19:35:03
tags:
---

### 创建配置文件

```bash
touch /etc/apache2/sites-available/dokuwiki.conf
ln -s /etc/apache2/sites-available/dokuwiki.conf /etc/apache2/sites-enabled/dokuwiki.conf
```

### 编辑配置文件

```
vim /etc/apache2/sites-available/dokuwiki.conf
```

内容如下

```
  <Directory /var/www/dokuwiki>
        order deny,allow
        allow from all
  </Directory>
  <LocationMatch "/(data|conf|bin|inc)/">
        order allow,deny
        deny from all
        satisfy all
  </LocationMatch>
```

重启apache

```bash
service apache2 restart
```


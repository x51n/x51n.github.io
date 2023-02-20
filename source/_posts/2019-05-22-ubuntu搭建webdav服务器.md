---
title: ubuntu搭建webdav服务器
categories:
  - 未归类
date: 2019-05-22 17:04:26
tags:
---

### 0x01 **Apache2 服务器配置**:

#####  （1）启用相关模块

```
sudo a2enmod dav_fs
sudo a2enmod dav
sudo a2enmod dav_lock
```

##### （2）重启 Apache2 服务:

```
sudo service apache2 restart
```

##### （3）创建虚拟主机目录:

```
mkdir /var/www/sync
chown www-data:www-data /var/www/sync
```

##### （4）创建用户:

```
sudo htpasswd -c /var/www/me.dav starky
// 这里会要求你设置密码，后面登录时会用到，用户名即为 starky
sudo chown root:www-data /var/www/me.dav
sudo chmod 640 /var/www/me.dav
```

##### **（5）配置虚拟主机:**

```
sudo vim /etc/apache2/sites-available/webdav.conf
```

```
<VirtualHost *:80>
     ServerAdmin webmaster@localhost
     DocumentRoot /var/www/sync/
     <Directory /var/www/sync/>
             Options MultiViews
             AllowOverride None
             Require all granted
     </Directory>

     Alias /webdav /var/www/sync
    
     <Location /webdav>
        DAV On
        AuthType Basic
        AuthName "webdav"
        AuthUserFile /var/www/me.dav
        Require valid-user
    </Location>
</VirtualHost>
```

```
cd /etc/apache2/sites-enabled/
sudo ln -s ../sites-available/webdav.conf webdav.conf
sudo rm 000-default.conf
```


### 0x02. 验证

使用命令行 cadaver 进入登录

```
sudo service apache2 restart
sudo apt-get install cadaver
cadaver http://127.0.0.1/webdav/
```


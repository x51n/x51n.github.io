title: Nginx 反向代理goolge
categories:
  - 未归类
date: 2019-04-12 21:35:25
tags: 
password: qaz123456

---

条件

* 一个墙外的VPS
* 一个域名
* 域名ＳＳＬ证书

### 安装并编译Nginx

安装环境

```
# apt-get update
# apt-get install libpcre3 libpcre3-dev
# apt-get install zlib1g zlib1g-dev openssl libssl-dev
# apt-get install libxml2 libxml2-dev libxslt1-dev
# apt-get install libgd-dev libgeoip-dev
# apt-get install -y gcc g++ make automake
```

安装nginx

```
apt-get install nginx
```

查看发行版

```bash
# nginx -V
nginx version: nginx/1.9.3 (Ubuntu)
built with OpenSSL 1.0.2d 9 Jul 2015
TLS SNI support enabled
configure arguments: --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_spdy_module --with-http_sub_module --with-http_xslt_module --with-mail --with-mail_ssl_module
```

下载模块

```
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module
git clone https://github.com/cuber/ngx_http_google_filter_module
```

编译

```bash
 cd nginx-1.9.3
 ./configure \
 --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_spdy_module --with-http_sub_module --with-http_xslt_module --with-mail --with-mail_ssl_module \
--add-module=../ngx_http_substitutions_filter_module \
--add-module=../ngx_http_google_filter_module
```

成功

```
Configuration summary
  + using system PCRE library
  + using system OpenSSL library
  + md5: using OpenSSL library
  + sha1: using OpenSSL library
  + using system zlib library

  nginx path prefix: "/usr/share/nginx"
  nginx binary file: "/usr/share/nginx/sbin/nginx"
  nginx configuration prefix: "/etc/nginx"
  nginx configuration file: "/etc/nginx/nginx.conf"
  nginx pid file: "/run/nginx.pid"
  nginx error log file: "/var/log/nginx/error.log"
  nginx http access log file: "/var/log/nginx/access.log"
  nginx http client request body temporary files: "/var/lib/nginx/body"
  nginx http proxy temporary files: "/var/lib/nginx/proxy"
  nginx http fastcgi temporary files: "/var/lib/nginx/fastcgi"
  nginx http uwsgi temporary files: "/var/lib/nginx/uwsgi"
  nginx http scgi temporary files: "/var/lib/nginx/scgi"
```

编译nginx

```
make 
make install 
```

配置

```
cp -rf objs/nginx /usr/sbin/nginx
```

关闭/启动　Nginx

```
systemctl stop nginx
systemctl start nginx
```

查看命令运行状态

````
systemctl status nginx
````

### 配置

编辑　`/etc/nginx/nginx.conf`

```json
http {
upstream www.google.com {
    # 这里的 IP 是写此文时可用的 IP，具体需要使用 nslookup 来查看
    server 172.217.0.4:443 weight=1;
    server 172.217.1.36:443 weight=1;
    server 216.58.193.196:443 weight=1;
    server 216.58.194.196:443 weight=1;
    server 216.58.195.196:443 weight=1;
    server 216.58.216.4:443 weight=1;
    server 216.58.216.36:443 weight=1;
    server 216.58.219.36:443 weight=1;
    server 172.217.6.36:443 weight=1;
}

server {
    listen <ip>:80;
    server_name <your.domain> ;
    return 301 https://$host$request_uri;
}

server {
    listen <ip>:443 ssl;
    server_name <your.domain>;
    resolver 8.8.8.8;

    ssl on;
    ssl_certificate /your/fullchain.pem;
    ssl_certificate_key /your/<google.domain>.key;

    # 如果服务跑在公网，则可能需要解除下面的注释，以确保不会被搜索引擎收录，以及下面维基百科的 server 配置也需要添加下面这些
    #if ($http_user_agent ~* "qihoobot|Baiduspider|Googlebot|Googlebot-Mobile|Googlebot-Image|Mediapartners-Google|Adsbot-Google|Feedfetcher-Google|Yahoo! Slurp|Yahoo! Slurp China|YoudaoBot|Sosospider|Sogou spider|Sogou web spider|MSNBot|ia_archiver|Tomato Bot") {
    #    return 403;
    #}

    access_log  off;
    error_log   on;
    error_log  /var/log/nginx/google-proxy-error.log;

    location / {
        proxy_redirect off;
        proxy_cookie_domain google.com <your.domain>;
        proxy_pass https://www.google.com;
        proxy_connect_timeout 60s;
        proxy_read_timeout 5400s;
        proxy_send_timeout 5400s;

        proxy_set_header Host "www.google.com";
        proxy_set_header User-Agent $http_user_agent;
        proxy_set_header Referer https://www.google.com;
        proxy_set_header Accept-Encoding "";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header Accept-Language "zh-CN";
        proxy_set_header Cookie "PREF=ID=047808f19f6de346:U=0f62f33dd8549d11:FF=2:LD=en-US:NW=1:TM=1325338577:LM=1332142444:GM=1:SG=2:S=rE0SyJh2W1IQ-Maw";

        subs_filter https://www.google.com.hk https://<your.domain>;
        subs_filter https://www.google.com https://<your.domain>;

        sub_filter_once off;
    }
}
}
```

检查配置文件并重载

```
nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful


systemctl restart nginx
```

---

参考：

<https://zhgcao.github.io/2016/06/09/nginx-reverse-proxy-google/>

<https://stdrc.cc/post/2018/10/23/reverse-proxy-of-google/>
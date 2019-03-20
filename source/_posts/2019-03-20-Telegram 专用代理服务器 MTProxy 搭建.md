title: Telegram 专用代理服务器 MTProxy 搭建
date: 2019-03-20 10:59:58
tags:
password: qaz123456

---

### 0x01 编译

安装环境,，ｄｅｂｉａｎ

```bash
apt install git curl build-essential libssl-dev zlib1g-dev
```

克隆并编译

```shell
git clone https://github.com/TelegramMessenger/MTProxy
cd MTProxy
make && cd objs/bin
```

### 0x02 运行

获取配置文件

```bash
curl -s https://core.telegram.org/getProxySecret -o proxy-secret
curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf
```

生成密钥

```bash
head -c 16 /dev/urandom | xxd -ps
```

试运行

```bash
./mtproto-proxy -u nobody -p 8888 -H 443 -S <生成的秘钥> --aes-pwd proxy-secret proxy-multi.conf -M 1
```

说明：

- nobody 为用户名
- ４４３试是客户端连接端口
- ８８８８是服务器本地端口

### 0x03 系统配置

将编译好的文件拷贝到指定文件夹

```bash
mkdir /opt/MTProxy
cp objs/bin/* /opt/MTProxy
```

创建系统服务文件

```
vim /etc/systemd/system/MTProxy.service
```

```bash
[Unit]
Description=MTProxy
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/MTProxy
ExecStart=/opt/MTProxy/mtproto-proxy -u nobody -p 8888 -H 443 -S <生成的秘钥> --aes-pwd proxy-secret proxy-multi.conf -M 1
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

配置服务

```
systemctl daemon-reload
systemctl restart MTProxy.service
# Check status, it should be active
systemctl status MTProxy.service
# Enable it, to autostart service after reboot:
systemctl enable MTProxy.service
```


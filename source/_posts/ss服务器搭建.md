---
title: SS服务端搭建
date: 2017-03-18 15:25:58
---
## SS服务端搭建

```bash
python --version
yum install python-setuptools && easy_install pip
pip install shadowsocks
yum install m2crypto
vim /etc/shadowsocks.json

#编辑shadowsocks.json的内容主要是IP与密码
  {
    "server":"本机外网IP",
      "server_port":8388,
      "local_address": "127.0.0.1",
      "local_port":1080,
      "password":"密码",
      "timeout":600,
      "method":"aes-256-cfb",
      "fast_open": false
  }
/usr/local/bin/ssserver -c /etc/shadowsocks.json
#或者使用nohup启动
nohup /usr/bin/ssserver -c /etc/shadowsocks.json
```

---
title: Ngrok服务端搭建与linux\mac\window客户端的编译
date: 2016-03-22 20:20:58
tags: [linux,ngrok,搭建]
---

## ngrok 服务编译的前提

```bash
wget https://storage.googleapis.com/golang/go1.4.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.4.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
```

## ngrok 服务端
```bash
cd /usr/local
git clone https://github.com/inconshreveable/ngrok.git
cd ngrok

openssl genrsa -out rootCA.key 2048;
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=ngrok.allji.cn" -days 5000 -out rootCA.pem;
openssl genrsa -out device.key 2048;
openssl req -new -key device.key -subj "/CN=ngrok.allji.cn" -out device.csr;
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000;

//copy
cp rootCA.pem ../ngrok/assets/client/tls/ngrokroot.crt;
cp device.crt ../ngrok/assets/server/tls/snakeoil.crt;
cp device.key ../ngrok/assets/server/tls/snakeoil.key;

make release-server
```

### 客户端 windows
```bash
cd /usr/local/go/src/;
GOOS=windows GOARCH=386 CGO_ENABLED=0 ./make.bash;
cd /usr/local/ngrok;
GOOS=windows GOARCH=386 make release-client;
```

### 客户端 linux
```bash
make release-client;
```

### 客户端 mac
```bash
cd /usr/local/go/src/;
GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 ./make.bash;
cd /usr/local/ngrok;
GOOS=darwin GOARCH=amd64 make release-client;
```

### 客户端 树莓派
```bash
cd /usr/local/go/src/;
GOOS=linux GOARCH=arm CGO_ENABLED=0 ./make.bash;
cd /usr/local/ngrok;
GOOS=linux GOARCH=arm make release-client;
```
### 运行
```bash
./bin/ngrokd -domain=“ngrok.dou2b.com" -httpAddr=":80" -httpsAddr=":443"

//客户端
./ngrok -subdomain "rplees" -config ngrok.cfg 8080

ngrok.cfg配置:
	server_addr: "ngrok.dou2b.com:4443"
	trust_host_root_certs: false

//是绑定一个rplees.yy.xx.com到本地的8080端口，具体参数相见 ngrok -help
```

### 问题
- 用 go1.5 运行会有一些问题，改用1.4的
- 如果服务端本身就已经有80、443的端口被占用了，而ngrok映射的地址又不想其他的端口，这时候可以用docker解决(原理就是docker容器的80、433端口映射到服务器上的580、5443端口，在用nginx反向代理解决)

### docker部分
#### 我的是centos环境[安装](https://docs.docker.com/engine/installation/linux/centos/)。其他的请参考[官网](https://docs.docker.com)


```bash
FROM ubuntu:14.04

MAINTAINER rplees rplees.i.ly@gmail.com

ENV NGROK /usr/local/ngrok
ENV DOMAIN ngrok.dou2b.com

EXPOSE 80 443 4443

COPY bin/ngrokd $NGROK/
COPY run-ser.sh $NGROK/

RUN chmod +x $NGROK/run-ser.sh

CMD $NGROK/run-ser.sh
```
保存到Dockerfile

#### run-ser.sh
```bash
#!/bin/bash
/usr/local/ngrok/ngrokd -domain ngrok.dou2b.com
```
保存到当前的Dockerfile路径的run-ser.sh

将 /user/local/ngrok/bin/ngrokd 拷贝到当前的Dockerfile路径的 bin/ngrokd

运行``docker build -t rplees/ngrokd .``等等执行完成.
执行 ``docker images`` 查看下现在的容器.

启动 ``docker run -d -p 580:80 -p 5443:443 -p 4443:4443 rplees/ngrokd:latest``
``docker ps -a``查看容器的状态
查看日志 ``docker logs <tag>``


#### nginx 配置
```bash
	map $scheme $proxy_port {
    	"http"  "580";
	    "https" "5443";
    	default "580";
	}
    server {
        listen      80;
        listen      443;
        server_name ngrok.dou2b.com *.ngrok.dou2b.com;
        location / {
            proxy_pass  $scheme://127.0.0.1:$proxy_port;
        }
        ssl on;
        ssl_certificate /usr/local/ngrok/assets/server/tls/snakeoil.crt;
        ssl_certificate_key /usr/local/ngrok/assets/server/tls/snakeoil.key;

        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    Host $http_host;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;

        access_log off;
        log_not_found off;
    }
```

###docker操作命令
```
service docker stop
service docker start

docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
docker images|grep none|awk '{print $3 }'|xargs docker rmi
docker run -d -p 580:80 -p 5443:443 -p 4443:4443 rplees/ngrokd:latest
```

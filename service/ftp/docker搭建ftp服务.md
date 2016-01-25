# 使用docker搭建ftp服务

使用 `pure-ftpd`

[pure-ftpd参考](https://download.pureftpd.org/pure-ftpd/doc/README.Virtual-Users)

## docker-compose.yml

image : [stilliard/pure-ftpd](https://hub.docker.com/r/stilliard/pure-ftpd/)

[GitHub](https://github.com/stilliard/docker-pure-ftpd)

```shell
➜  ftp cat docker-compose.yml
ftp:
  image: stilliard/pure-ftpd
  volumes:
    - "$PWD/ftpusers:/home/ftpusers"
    - "$PWD/pure-ftpd:/etc/pure-ftpd"
    - /etc/localtime:/etc/localtime:ro
  ports:
    - "21:21"
    - "30000:30000"
    - "30001:30001"
    - "30002:30002"
    - "30003:30003"
    - "30004:30004"
    - "30005:30005"
    - "30006:30006"
    - "30007:30007"
    - "30008:30008"
    - "30009:30009"
  environment:
    PUBLICHOST: 192.168.55.15 # ftp服务器IP,或者域名
    - TZ=Asia/Shanghai
```

## 创建并启动

这个过程会自动pull `stilliard/pure-ftpd` 镜像,也可以先pull下来

    docker-compose up -d

## 创建用户

容器内执行:

    pure-pw useradd xxx -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/xxx

删除用户(禁止用户登录,不会删除设置的家目录,以及文件)

    pure-pw useradd xxx

会提示输入密码,照做即可

## 测试连接

    ftp -p localhost 21

# docker

## 安装

[docker安装教程](http://mirrors.aliyun.com/help/docker-engine)

[docs-docker](https://docs.docker.com/)

系统要求

* Ubuntu 14.04、16.04
* Debian 7.7、8.0
* CentOS 7.X
* Fedora 20、21、22
* OracleLinux 6、7

If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

    sudo usermod -aG docker your-user

Remember that you will have to log out and back in for this to take effect!

## docker-compose

[GitHub-docker-compose](https://github.com/docker/compose/releases)

[docs-docker-compose](https://docs.docker.com/compose/install/)

由于GitHub的访问问题,Linux系统的Docker Compose下载也不稳定,所以可以从阿里云镜像站下载

[阿里云docker-toolbox](http://mirrors.aliyun.com/docker-toolbox/)

下载对应系统即可

```shell
wget http://mirrors.aliyun.com/docker-toolbox/linux/compose/1.10.0/docker-compose-Linux-x86_64
cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

root@ubuntu47:~/src# docker-compose -v
docker-compose version 1.10.0, build 4bd6f1a
```
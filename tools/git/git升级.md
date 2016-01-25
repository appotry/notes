## 1 centos 7.2 git 1.8.3升级到2.11.0

[参考 centos 7 升级/安装 git 2.7.3](http://blog.csdn.net/jinwufeiyang/article/details/51933925)

### 1.1 卸载旧版本并安装所需软件包

```shell
# rpm -qa git
git-1.8.3.1-5.el7.x86_64
# rpm -e --nodeps git-1.8.3.1-5.el7.x86_64

# yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel glibc-static libstdc++-static -y
# yum install gcc perl-ExtUtils-MakeMaker -y
```

### 1.2 下载&安装

```shell
# cd /usr/src
# wget https://www.kernel.org/pub/software/scm/git/git-2.11.0.tar.gz
# tar xf git-2.11.0.tar.gz

# ./configure
# make prefix=/usr/local/git all
# make prefix=/usr/local/git install
# echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc
# source /etc/bashrc
```

### 1.3 检查版本

```shell
# git --version
git version 2.11.0
```

# 1. GitLab

<!-- TOC -->

- [1. GitLab](#1-gitlab)
    - [1.1. 环境准备](#11-环境准备)
        - [1.1.1. 硬件需求](#111-硬件需求)
            - [1.1.1.1. 存储](#1111-存储)
            - [1.1.1.2. CPU](#1112-cpu)
            - [1.1.1.3. Memory](#1113-memory)
        - [1.1.2. 系统环境](#112-系统环境)
    - [1.2. 安装GitLab](#12-安装gitlab)
        - [1.2.1. 使用官方一键安装包](#121-使用官方一键安装包)
            - [1.2.1.1. 安装配置依赖项](#1211-安装配置依赖项)
            - [1.2.1.2. 添加GitLab仓库,并安装到服务器上](#1212-添加gitlab仓库并安装到服务器上)
            - [1.2.1.3. 启动GitLab](#1213-启动gitlab)
            - [1.2.1.4. 使用浏览器访问GitLab](#1214-使用浏览器访问gitlab)
        - [1.2.2. 使用docker部署GitLab](#122-使用docker部署gitlab)

<!-- /TOC -->

## 1.1. 环境准备

### 1.1.1. 硬件需求

#### 1.1.1.1. 存储

存储空间的大小主要取决于你将存储的Git仓库的大小。但根据 rule of thumb(经验法则) 你应该考虑多留一些空间用来存储Git仓库的备份。

如果你想使用弹性的存储空间，你可以考虑在分配分区的时候使用LVM架构，这样可以在后期需要的清空下添加硬盘在增加存储空间。

除此之外你还可以挂在一个支持NFS的分卷，比如NAS、 SAN、AWS、EBS。

如果你的服务器有足够大的内存和CPU处理性能，GitLab的响应速度主要受限于硬盘的寻道时间。 使用更快的硬盘(7200转)或者SSD硬盘会很大程度的提升GitLab的响应速度。

#### 1.1.1.2. CPU

* 1 核心CPU最多支持100个用户，所有的workers和后台任务都在同一个核心工作这将导致GitLab服务响应会有点缓慢。
* 2核心 支持500用户，这也是官方推荐的最低标准。
* 4 核心支持2,000用户。
* 8 核心支持5,000用户。
* 16 核心支持10,000用户。
* 32 核心支持20,000用户。
* 64 核心支持40,000用户。
* 如果想支持更多用户，可以使用 集群式架构

#### 1.1.1.3. Memory

安装使用GitLab需要至少4GB可用内存(RAM + Swap)! 由于操作系统和其他正在运行的应用也会使用内存, 所以安装GitLab前一定要注意当前服务器至少有4GB的可用内存. 少于4GB内存会导致在reconfigure的时候出现各种诡异的问题, 而且在使用过程中也经常会出现500错误.

* 1GB 物理内存 + 3GB 交换分区 是最低的要求，但我们 强烈反对 使用这样的配置。
* 2GB 物理内存 + 2GB 交换分区 支持100用户，但服务响应会很慢。
* 4GB 物理内存 支持100用户，也是 官方推荐 的配置。
* 8GB 物理内存 支持 1,000 用户。
* 16GB 物理内存 支持 2,000 用户。
* 32GB 物理内存 支持 4,000 用户。
* 64GB 物理内存 支持 8,000 用户。
* 128GB 物理内存 支持 16,000 用户。
* 256GB 物理内存 支持 32,000 用户。

如果想支持更多用户，可以使用 集群式架构

即使你服务器有足够多的RAM， 也要给服务器至少分配2GB的交换分区。 因为使用交换分区可以在你的可用内存波动的时候降低GitLab出错的几率。

注意: Sidekiq的25个workers在查看进程(top或者htop)的时候会发现它会单独显示每个worker，但是它们是共享内存分配的，这是因为Sidekiq是一个多线程的程序。 详细内容查看下面关于Unicorn workers 的介绍。

### 1.1.2. 系统环境

```shell
[root@www ~]# cat /etc/redhat-release
CentOS release 6.7 (Final)
[root@www ~]# uname -r
2.6.32-573.el6.x86_64
```

## 1.2. 安装GitLab

### 1.2.1. 使用官方一键安装包

#### 1.2.1.1. 安装配置依赖项

如想使用Postfix来发送邮件,在安装期间请选择'Internet Site'. 您也可以用sendmai或者 配置SMTP服务并使用SMTP发送邮件.

在 Centos 6 和 7 系统上, 下面的命令将在系统防火墙里面开放HTTP和SSH端口.

```shell
sudo yum install curl openssh-server openssh-clients postfix cronie
sudo service postfix start
sudo chkconfig postfix on
sudo lokkit -s http -s ssh
```

#### 1.2.1.2. 添加GitLab仓库,并安装到服务器上

```shell
curl -sS http://packages.gitlab.cc/install/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce
```

如果你不习惯使用命令管道的安装方式, 你可以在这里下载 安装脚本 或者 手动下载您使用的系统相应的安装包(RPM/Deb) 然后安装

```shell
curl -LJO https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el6/gitlab-ce-XXX.rpm
rpm -i gitlab-ce-XXX.rpm
```

#### 1.2.1.3. 启动GitLab

    sudo gitlab-ctl reconfigure

#### 1.2.1.4. 使用浏览器访问GitLab

首次访问GitLab,系统会让你重新设置管理员的密码,设置成功后会返回登录界面.
默认的管理员账号是root,如果你想更改默认管理员账号,请输入上面设置的新密码登录系统后修改帐号名.

### 1.2.2. 使用docker部署GitLab

# ssh

<!-- TOC -->

- [ssh](#ssh)
    - [SSH会话连接超时问题解决办法](#ssh会话连接超时问题解决办法)
        - [方法一](#方法一)
        - [方法二](#方法二)
    - [scp](#scp)
        - [scp远程拷贝包含空格的目录或文件](#scp远程拷贝包含空格的目录或文件)
    - [ssh-copy-id](#ssh-copy-id)

<!-- /TOC -->

## SSH会话连接超时问题解决办法

### 方法一

如果显示空白,表示没有设置, 等于使用默认值0, 一般情况下应该是不超时. 如果大于0, 可以在如/etc/profile之类文件中设置它为0.

使用命令直接用户修改配置文件，设置`TMOUT=180`，即超时时间为3分钟

vim /etc/profile 添加下面两行

    设置为3分钟
    TMOUT=180

### 方法二

    查看使用的ssh客户端是否有类似功能

上述方法应该能解决大部分问题, 如果不行, 请 man sshd_config, 然后尝试更改其他设置吧.

1、设置服务器向SSH客户端连接会话发送频率和时间

```shell
vi /etc/ssh/sshd_config，添加如下两行

    ClientAliveInterval 60
    ClientAliveCountMax 86400

    注：
    ClientAliveInterval选项定义了每隔多少秒给SSH客户端发送一次信号；
    ClientAliveCountMax选项定义了超过多少秒后断开与ssh客户端连接
```

2、重新启动系统SSH服务

```shell
# service sshd restart

# Ubuntu 16.04.1 LTS:
systemctl reload ssh.service
```

## scp

    scp -P 50333 root@192.168.0.11:~/docker.docx .

### scp远程拷贝包含空格的目录或文件

使用反斜线转义,并使用双引号引起来

示例

    scp -r root@192.168.0.100:"/share/svn/coolest\ guy" /share/svn/

## ssh-copy-id

    ssh-copy-id -i ~/.ssh/id_rsa.pub -p 50333 root@192.168.0.11

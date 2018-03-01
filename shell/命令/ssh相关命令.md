# ssh

<!-- TOC -->

- [ssh](#ssh)
    - [SSH会话连接超时问题解决办法](#ssh会话连接超时问题解决办法)
        - [方法一](#方法一)
        - [方法二](#方法二)
    - [scp](#scp)
        - [scp远程拷贝包含空格的目录或文件](#scp远程拷贝包含空格的目录或文件)
    - [ssh-copy-id](#ssh-copy-id)
    - [问题](#问题)
        - [Unable to negotiate with xx.xx.xx.xx port 22: no matching cipher found. Their offer: aes256-cbc,aes128-cbc,3des-cbc,des-cbc](#unable-to-negotiate-with-xxxxxxxx-port-22-no-matching-cipher-found-their-offer-aes256-cbcaes128-cbc3des-cbcdes-cbc)

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

## 问题

### Unable to negotiate with xx.xx.xx.xx port 22: no matching cipher found. Their offer: aes256-cbc,aes128-cbc,3des-cbc,des-cbc

ssh -c aes256-cbc root@xx.xx.xx

```shell
man ssh

     -c cipher_spec
             Selects the cipher specification for encrypting the session.  cipher_spec is a comma-separated list of ciphers listed in order of preference.  See
             the Ciphers keyword in ssh_config(5) for more information.
```

```shell
man ssh_config

搜索

Ciphers

    The supported ciphers are:

        3des-cbc
        aes128-cbc
        aes192-cbc
        aes256-cbc
        aes128-ctr
        aes192-ctr
        aes256-ctr
        aes128-gcm@openssh.com
        aes256-gcm@openssh.com
        chacha20-poly1305@openssh.com

    The default is:

        chacha20-poly1305@openssh.com,
        aes128-ctr,aes192-ctr,aes256-ctr,
        aes128-gcm@openssh.com,aes256-gcm@openssh.com,
        aes128-cbc,aes192-cbc,aes256-cbc

    The list of available ciphers may also be obtained using "ssh -Q cipher".
```

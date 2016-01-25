# 1. Across the Great Wall

<!-- TOC -->

- [1. Across the Great Wall](#1-across-the-great-wall)
    - [1.1. 使用ShadowSocks(推荐)](#11-使用shadowsocks推荐)
        - [1.1.1. 搭建ShadowSocks服务器](#111-搭建shadowsocks服务器)
        - [1.1.2. 使用ShadowSocks客户端](#112-使用shadowsocks客户端)
            - [1.1.2.1. 安装ShadowSocks客户端](#1121-安装shadowsocks客户端)
            - [1.1.2.2. Mac 客户端配置](#1122-mac-客户端配置)
            - [1.1.2.3. Google浏览器使用自动代理模式](#1123-google浏览器使用自动代理模式)
            - [1.1.2.4. Windows客户端使用PAC代理模式](#1124-windows客户端使用pac代理模式)
    - [1.2. SSH(未测试)](#12-ssh未测试)
        - [1.2.1. 免费SSH代理](#121-免费ssh代理)

<!-- /TOC -->

## 1.1. 使用ShadowSocks(推荐)

### 1.1.1. 搭建ShadowSocks服务器

https://blog.phpgao.com/shadowsocks_on_linux.html

### 1.1.2. 使用ShadowSocks客户端

#### 1.1.2.1. 安装ShadowSocks客户端

[Mac 客户端下载](https://github.com/shadowsocks/ShadowsocksX-NG)

[Windows 客户端下载](https://github.com/shadowsocks/shadowsocks-windows/releases)

#### 1.1.2.2. Mac 客户端配置

安装shadowsocks之后,打开,在任务栏会有一个小飞机的图标

1. 勾选 Proxy Auto Configure Mode (启动自动代理模式)
2. 配置 Servers -> Server Preferences (添加SS服务器)


![shadowsocks-1](http://oi480zo5x.bkt.clouddn.com/shadowsocks-1.png)

3. 填写SS服务器相关信息,信息不能有误,否则代理无法上网

![shadowsocks-2-Server-preferences](http://oi480zo5x.bkt.clouddn.com/shadowsocks-2-Server-preferences.png)

4. 配置Shadowsocks客户端,Socks5监听地址及端口 Preferences -> Advanced

这里配置的内容,将会在Proxy SwitchyOmega中使用到

![shadowsocks-3-Listen-Port](http://oi480zo5x.bkt.clouddn.com/shadowsocks-3-Listen-Port.png)

到此Shadowsocks客户端配置完毕

#### 1.1.2.3. Google浏览器使用自动代理模式

为什么要使用自动代理?

被墙的网站,使用代理上网,而国内网站,直接访问(避免国内网站访问速度过慢)

> 安装 Proxy SwitchyOmega

下载谷歌浏览器Chrome代理插件 [Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif?hl=en-US)

[GitHub: SwitchyOmega](https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList)

[GitHub: gfwlist](https://github.com/gfwlist/gfwlist)

[GFWList URL(Github)](https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt)

> 配置 Proxy SwitchyOmega(可以直接从文件恢复配置)

从文件恢复配置,在线恢复,地址:

`http://oi480zo5x.bkt.clouddn.com/OmegaOptions-XX.bak`

![shadowsocks-7-restore-from-online](http://oi480zo5x.bkt.clouddn.com/shadowsocks-7-restore-from-online.png)

Proxy SwitchyOmega的使用

![shadowsocks-4-SwitchyOmega-proxy](http://oi480zo5x.bkt.clouddn.com/shadowsocks-4-SwitchyOmega-proxy.png)

Rule List URL : `https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt`

![shadowsocks-5-SwitchyOmega-autoswitch](http://oi480zo5x.bkt.clouddn.com/shadowsocks-5-SwitchyOmega-autoswitch.png)

Google浏览器启用 SwitchyOmega autoswitch即可

![shadowsocks-6-autoswitch](http://oi480zo5x.bkt.clouddn.com/shadowsocks-6-autoswitch.png)

#### 1.1.2.4. Windows客户端使用PAC代理模式

配置好Shadowsocks之后,先使用全局模式,更新PAC规则,再切换到PAC代理模式即可

## 1.2. SSH(未测试)

### 1.2.1. 免费SSH代理

http://alidage.org/

http://blog.onlybird.com/getfreessh

如何把VPS作为SSH代理翻墙

VPS 不仅可以用来搭建 PPTP、L2TP/IPSec 和 OpenVPN，而且还可以直接作为 SSH 代理翻墙。

以下将介绍一个如何把 VPS 作为 SSH 代理翻墙的简易方法

```txt
I、连接 VPS

    对 Windows 来讲，你可以安装一个 SSH 客户端（例如 Tunnelier）, 对 Mac 来讲，你也可以安装一个 SSH 客户端（例如 Issh），但更简单的方法是直接在终端应用程序上通过以下命令连接：
    ssh -N -D 7070 root@94.249.184.93
    记得将 “94.249.184.93″ 替换成你 VPS 的 IP 地址，按下 “Return” 键，输入 VPS 登录密码，如果正确，回车后你将看不到任何新的内容。
    顺便说一下，不管你的 VPS 事先是否已经安装了 VPN，你都可以把 VPS 作为 SSH 代理，这不会影响 VPN 的使用。
    技巧：
    尽管以上是最简单的连接方法，但是只能供你一个人使用――除非你想把自己的 VPS 帐户和别人分享。而如果要和别人分享同一个 SSH 代理，你可以通过以下 4 个步骤新建一个受限的 VPS 用户:

1、登录 VPS
    在终端应用程序上输入以下命令：
    SSH root@94.249.184.93
    记得将 “94.249.184.93″ 替换成你 VPS 的 IP 地址。

    ssh -qTfnN -D 7070  xxx@x.x.x.x
    之后输入SSH密码，如果SSH端口不是22，而是自定义的，则为：
    ssh -qTfnN -D 7070 xxx@x.x.x.x -p port
    上面的xxx表示SSH账号名，x.x.x.x表示SSH的服务器地址，port表示SSH的端口号，默认为22。

2、创建一个用户组

    输入以下命令：
    groupadd sshproxy
    你可以将 “sshproxy” 替换成任意名字。

3、创建受限用户

    输入以下命令：
    useradd -d /home/sshproxy -m -g sshproxy -s /bin/false sshproxy
    以上命令将会在 “sshproxy” 创建一个新的 SSH 用户 “sshproxy”，该用户只能使用 SSH 代理，不能登录你的 VPS 帐户。

4、为新用户设置密码

    输入以下命令：
    passwd sshproxy
    然后，为该用户设置任意密码 (例如 “123456″)。
    完了之后，你就可以把该用户名和密码分享给朋友，他们也就可以通过以下命令使用你的 SSH 代理：
    ssh -N -D 7070 sshproxy@94.249.184.93
    记得把 “sshproxy” 替换成你新建的用户名，把 “94.249.184.93″ 替换成你 VPS 的 IP 地址。
```

也可以使用Firefox浏览器的扩展AutoProxy,[下载地址](https://addons.mozilla.org/zh-cn/firefox/addon/autoproxy/)

安装之后，打开 AutoProxy首选项——代理服务器——选择代理服务器，选择ssh -D选项。如图所示：

这种方法的前提是你有国外的SSH账号。网上也有很多免费的，可以Google搜索 ssh免费代理 。


# Mac下命令行工具

## 终端查看Mac系统版本

`sw_vers`

```shell
➜  ~ sw_vers
ProductName:    Mac OS X
ProductVersion: 10.11.6
BuildVersion:   15G31
```

## 查看端口情况

```shell
netstat -nat |grep LISTEN

lsof -n -P -i TCP -s TCP:LISTEN

# lsof命令可以列出当前的所有网络情况， 此命令的解释如下：
# -n 表示主机以ip地址显示
# -P 表示端口以数字形式显示，默认为端口名称
# -i 意义较多，具体 man lsof, 主要是用来过滤lsof的输出结果
# -s 和 -i 配合使用，用于过滤输出
```

## mtr

### Mac

[下载地址](http://rudix.org/packages/mtr.html)

### Windows

WinMTR

### mtr命令使用

```shell
➜  ~ mtr -r www.baidu.com
Start: Thu Sep 28 11:28:39 2017
HOST: Y.local                 Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 172.16.0.66                0.0%    10    4.2   3.5   1.6   6.3   1.2
  2.|-- 172.16.0.66                0.0%    10    4.0   3.1   2.0   4.0   0.3
  3.|-- ???                       100.0    10    0.0   0.0   0.0   0.0   0.0
  4.|-- ???                       100.0    10    0.0   0.0   0.0   0.0   0.0
  5.|-- 61.51.113.37              50.0%    10   14.2  10.4   2.9  28.1  10.9
  6.|-- 124.65.56.137             80.0%    10    6.0   5.2   4.4   6.0   1.0
  7.|-- 61.148.152.18              0.0%    10   14.8  16.8   3.9  42.7  14.1
  8.|-- 123.125.248.42            40.0%    10    8.2   6.8   2.6  11.6   2.9
  9.|-- ???                       100.0    10    0.0   0.0   0.0   0.0   0.0
 10.|-- 61.135.169.121             0.0%    10    6.1   6.7   2.9  14.6   3.9
```

```shell
其中-c的说明是：–report-cycles COUNT 每秒发送数据包的数量

第三列:是显示的每个对应IP的丢包率
第四列:显示的最近一次的返回时延
第五列:是平均值 这个应该是发送ping包的平均时延
第六列:是最好或者说时延最短的
第七列:是最差或者说时延最常的
第八列:是标准偏差
```

参数说明

```shell
mtr -h 显示帮助信息
mtr -v 显示mtr版本
mtr -r 报告模式显示
mtr -s 用来指定ping数据包的大小
mtr -n no-dns不对IP地址做域名解析
mtr -a 来设置发送数据包的IP地址 这个对一个主机由多个IP地址是有用的
mtr -i 使用这个参数来设置ICMP返回之间的要求默认是1秒
mtr -4 使用IPv4
mtr -6 使用IPv6
```

## dscl -- Directory Service command line utility

[参考](https://www.jianshu.com/p/a0e61f65d539)

### 实例

创建用户

```shell
dscl . -create /Users/用户名
dscl . -create /Users/用户名 UserShell /bin/bash
dscl . -create /Users/用户名 RealName "真实用户名"
dscl . -create /Users/用户名 UniqueID "502"
dscl . -create /Users/用户名 PrimaryGroupID 80
dscl . -create /Users/用户名 NFSHomeDirectory /Users/用户名

dscl . -passwd /Users/用户名 "密码"

dscl . -append /Groups/admin GroupMembership 用户名
```

### 删除用户

```shell
dscl . -delete /Users/用户名
```

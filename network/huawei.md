# 华为S5700配置

<extoc></extoc>

## tips

命令前几位唯一的时候, 可以使用缩写

例如, `display`可以使用简写`dis`

### 帮助信息

输入  `?`  会直接显示帮助信息

示例:

```shell
<S5700-28C-EI_1>?
<S5700-28C-EI_1>dis?

<S5700-28C-EI_1>display ?
```

## 常用命令

### 查看Mac地址

    display mac-address

查看Mac及对应IP,ARP缓存表

    display arp

### 查看当前生效的配置信息

    display current-configuration

对于正在生效的缺省配置，此命令不予显示。

### 进入系统视图

```shell
system-view
sys
# Enter system view, return user view with Ctrl+Z.
```

### 显示端口vlan信息，display可缩写为dis

    display port vlan

### 进入端口进行配置

```shell
int

<S5700-24TP-PWR-SI_1>display port vlan
```

```shell
[S5700-24TP-PWR-SI_1]dis vlan
[S5700-24TP-PWR-SI_1]dis interface brief
PHY: Physical
*down: administratively down
(l): loopback
(s): spoofing
(E): E-Trunk down
(b): BFD down
(e): ETHOAM down
(dl): DLDP down
(d): Dampening Suppressed
InUti/OutUti: input utility/output utility
Interface                   PHY   Protocol InUti OutUti   inErrors  outErrors
GigabitEthernet0/0/1        up    up       0.01%  0.11%          0          0

[S5700-24TP-PWR-SI_1]int
```

### 过滤

    include

    示例: display arp | inc 192

### 关闭端口

```shell
[S5700-24TP-PWR-SI_1]interface GigabitEthernet 0/0/1
[S5700-24TP-PWR-SI_1-GigabitEthernet0/0/1]shutdown
```

### 查看状态(up,down)

- `dis interface brief`
- `dis  ip int brief`

```shell
<S5700-24TP-PWR-SI_1>dis interface brief
PHY: Physical
*down: administratively down
(l): loopback
(s): spoofing
(E): E-Trunk down
(b): BFD down
(e): ETHOAM down
(dl): DLDP down
(d): Dampening Suppressed
InUti/OutUti: input utility/output utility
Interface                   PHY   Protocol InUti OutUti   inErrors  outErrors
GigabitEthernet0/0/1        *down down        0%     0%          0          0
GigabitEthernet0/0/2        up    up       0.01%  0.01%          0          0
GigabitEthernet0/0/3        *down down        0%     0%          0          0
GigabitEthernet0/0/4        *down down        0%     0%          0          0
GigabitEthernet0/0/5        *down down        0%     0%          0          0
GigabitEthernet0/0/6        *down down        0%     0%          0          0
GigabitEthernet0/0/7        *down down        0%     0%          0          0
GigabitEthernet0/0/8        *down down        0%     0%          0          0
GigabitEthernet0/0/9        *down down        0%     0%          0          0
GigabitEthernet0/0/10       *down down        0%     0%          0          0
GigabitEthernet0/0/11       *down down        0%     0%          0          0
GigabitEthernet0/0/12       *down down        0%     0%          0          0
GigabitEthernet0/0/13       *down down        0%     0%          0          0
GigabitEthernet0/0/14       *down down        0%     0%          0          0
GigabitEthernet0/0/15       *down down        0%     0%          0          0
GigabitEthernet0/0/16       *down down        0%     0%          0          0
GigabitEthernet0/0/17       *down down        0%     0%          0          0
GigabitEthernet0/0/18       *down down        0%     0%          0          0
GigabitEthernet0/0/19       *down down        0%     0%          0          0
GigabitEthernet0/0/20       up    up       0.01%  0.01%          0          0
GigabitEthernet0/0/21       *down down        0%     0%          0          0
GigabitEthernet0/0/22       *down down        0%     0%          0          0
GigabitEthernet0/0/23       *down down        0%     0%          0          0
GigabitEthernet0/0/24       up    up       0.14%  0.01%     464676          0
```

### 查看端口类型

[http://bbs.51cto.com/thread-88186-1.html](http://bbs.51cto.com/thread-88186-1.html)

Access端口只属于1个VLAN，所以它的缺省VLAN就是它所在的VLAN，不用设置；

Hybrid端口和Trunk端口属于多个VLAN，所以需要设置缺省`VLAN ID`。缺省情况下，Hybrid端口和Trunk端口的缺省VLAN为VLAN 1

如果设置了端口的缺省`VLAN ID`，当端口接收到不带VLAN Tag的报文后，则将报文转发到属于缺省VLAN的端口；当端口发送带有VLAN Tag的报文时，如果该报文的VLAN ID与端口缺省的VLAN ID相同，则系统将去掉报文的VLAN Tag，然后再发送该报文。

> 华为交换机缺省VLAN被称为"Pvid Vlan"， 对于思科交换机缺省VLAN被称为"Native Vlan"

```shell
<S5700-28C-EI_1>dis port ?
  protect-group  Protect-group index
  vlan           Virtual LAN

<S5700-28C-EI_1>display port vlan
...
```

#### Acess

Acess端口收报文

收到一个报文,判断是否有VLAN信息：如果没有则打上端口的PVID，并进行交换转发,如果有则直接丢弃（缺省）

Acess端口发报文

将报文的VLAN信息剥离，直接发送出去

#### trunk

trunk端口收报文

收到一个报文，判断是否有VLAN信息：如果没有则打上端口的PVID，并进行交换转发，如果有判断该trunk端口是否允许该 VLAN的数据进入：如果可以则转发，否则丢弃

trunk端口发报文

比较端口的PVID和将要发送报文的VLAN信息，如果两者相等则剥离VLAN信息，再发送，如果不相等则直接发送

#### hybrid

hybrid端口收报文

收到一个报文,判断是否有VLAN信息：如果没有则打上端口的PVID，并进行交换转发，如果有则判断该hybrid端口是否允许该VLAN的数据进入：如果可以则转发，否则丢弃(此时端口上的untag配置是不用考虑的，untag配置只对发送报文时起作用)

hybrid端口发报文

1. 判断该VLAN在本端口的属性（disp interface 即可看到该端口对哪些VLAN是untag， 哪些VLAN是tag）
2. 如果是untag则剥离VLAN信息，再发送，如果是tag则直接发送

## 示例

### 修改时间

```shell
<S5700-24TP-PWR-SI_2>dis clock
2017-05-31 15:08:07-05:13
Wednesday
Time Zone(Indian Standard Time) : UTC-05:13

<S5700-24TP-PWR-SI_2>clock timezone BJ add 8
<S5700-24TP-PWR-SI_2>clock datetime 15:09:00 2017-05-31

<S5700-24TP-PWR-SI_2>dis clock
2017-05-31 15:09:04+08:00
Wednesday
Time Zone(BJ) : UTC+08:00
```

### 设置NTP

```shell
设置NTP
[Quidway]ntp-service unicast-server X.X.X.X
设置时区
<Quidway>clock timezone BJ add 8
```

### 静态绑定IP与Mac地址

DHCP服务使用的全局模式

```shell
# 进入对应地址池
ip pool 192.168.77.0

#绑定

sys
ip pool 192.168.77.0
static-bind ip-address 192.168.77.223 mac-address 28f3-6623-b8e9

static-bind ip-address 192.168.0.211 mac-address c48e-8f74-14b9

### 如果有如下报错,原因是IP被使用,或者已经分配,此时需要释放全局地址池的该IP(需要在用户视图下执行)
(如果释放之后还提示该错误,是因为操作不够快,写好命令直接粘贴就可以了)
Error: The IP address's status is error.

# ---
下面是释放全局地址池名称为mypool的192.168.20.230这个IP的示例
reset ip pool name mypool 192.168.20.230

比如:
reset ip pool name 192.168.20.0 192.168.20.230

如果报如下错误, 则是因为已经给这个mac地址分配过IP了, 将该IP重置即可
Error: The static-MAC is exist in this IP-pool.
```

## 华为交换机常用命令

### 查看当前视图下的配置信息

    display this

```shell
显示当前配置  display current-configuration
显示接口信息  display interface GigabitEthernet 1/1/4
显示cpu信息  display cpu
显示接口acl应用信息  display packet-filter interface GigabitEthernet 1/1/4
显示所有acl设置(3900系列交换机)    display acl all
显示所有acl设置(6500系列交换机)    display acl config all
显示该ip地址的mac地址，所接交换机的端口位置    display arp 10.78.4.1

进入系统图(配置交换机)    system-view  (等于config t 命令)

设置路由    ip route-static 0.0.0.0 0.0.0.0 10.78.1.1 preference 60
重置接口信息  reset counters interface Ethernet 1/0/14

保存设置    save
退出      quit
```

```shell
11. acl number 5000 在system-view命令后使用，进入acl配置状态
12. rule 0 deny 0806 ffff 24 0a4e0401 f 40 在上面的命令后使用，，acl 配置例子
13. rule 1 permit 0806 ffff 24 000fe218ded7 f 34 //在上面的命令后使用，acl配置例子
14. interface GigabitEthernet 1/0/9 //在system-view命令后使用，进入接口配置状态
15. [86ZX-S6503-GigabitEthernet1/0/9]qos //在上面的命令后使用，进入接口qos配置
16. [86ZX-S6503-qosb-GigabitEthernet1/0/9]packet-filter inbound user-group 5000 //在上面的命令后使用，在接口上应用进站的acl
17. [Build4-2_S3928TP-GigabitEthernet1/1/4]packet-filter outbound user-group 5001 //在接口上应用出站的acl16. undo acl number 5000 //取消acl number 5000 的设置
```

## 其他

### 单交换机VLAN划分

　　命令 命令解释
　　system 进入系统视图
　　system-view 进入系统视图
　　quit 退到系统视图
　　undo vlan 20 删除vlan 20
　　sysname 交换机命名
　　disp vlan 显示vlan
　　vlan 20 创建vlan(也可进入vlan 20)
　　port e1/0/1 to e1/0/5 把端口1-5放入VLAN 20 中
　　disp vlan 20 显示vlan里的端口20
　　int e1/0/24 进入端口24
　　port access vlan 20 把当前端口放入vlan 20
　　undo port e1/0/10 表示删除当前VLAN端口10
　　disp curr 显示当前配置

### 配置交换机支持TELNET

　　system 进入系统视图
　　sysname 交换机命名
　　int vlan 1 进入VLAN 1
　　ip address 192.168.3.100 255.255.255.0 配置IP地址
　　user-int vty 0 4 进入虚拟终端
　　authentication-mode password (aut password) 设置口令模式
　　set authentication password simple 222 (set aut pass sim 222) 设置口令
　　user privilege level 3(use priv lev 3) 配置用户级别
　　disp current-configuration (disp cur) 查看当前配置
　　disp ip int 查看交换机VLAN IP配置
　　删除配置必须退到用户模式
　　reset saved-configuration(reset saved) 删除配置
　　reboot 重启交换机

### 跨交换机VLAN的通讯

　　在sw1上：
　　vlan 10 建立VLAN 10
　　int e1/0/5 进入端口5
　　port access vlan 10 把端口5加入vlan 10
　　vlan 20 建立VLAN 20
　　int e1/0/15 进入端口15
　　port access vlan 20 把端口15加入VLAN 20
　　int e1/0/24 进入端口24
　　port link-type trunk 把24端口设为TRUNK端口
　　port trunk permit vlan all 同上
　　在SW2上:
　　vlan 10 建立VLAN 10
　　int e1/0/20 进入端口20
　　port access vlan 10 把端口20放入VLAN 10
　　int e1/0/24 进入端口24
　　port link-type trunk 把24端口设为TRUNK端口
　　port trunk permit vlan all (port trunk permit vlan 10 只能为vlan 10使用)24端口为所有VLAN使用
　　disp int e1/0/24 查看端口24是否为TRUNK
　　undo port trunk permit vlan all 删除该句

### 路由的配置命令

　　system 进入系统模式
　　sysname 命名
　　int e1/0 进入端口
　　ip address 192.168.3.100 255.255.255.0 设置IP
　　undo shutdown 打开端口
　　disp ip int e1/0 查看IP接口情况
　　disp ip int brief 查看IP接口情况
　　user-int vty 0 4 进入口令模式
　　authentication-mode password(auth pass) 进入口令模式
　　set authentication password simple 222 37 设置口令
　　user privilege level 3 进入3级特权
　　save 保存配置
　　reset saved-configuration 删除配置(用户模式下运行)
　　undo shutdown 配置远程登陆密码
　　int e1/4
　　ip route 192.168.3.0(目标网段) 255.255.255.0 192.168.12.1(下一跳：下一路由器的接口) 静态路由
　　ip route 0.0.0.0 0.0.0.0 192.168.12.1 默认路由
　　disp ip rout 显示路由列表
　　华3C AR-18
　　E1/0(lan1-lan4)
　　E2/0(wan0)
　　E3/0(WAN1)
　　路由器连接使用直通线。wan0接wan0或wan1接wan1
　　计算机的网关应设为路由器的接口地址。

### 三层交换机配置VLAN-VLAN通讯

　　sw1(三层交换机):
　　system 进入视图
　　sysname 命名
　　vlan 10 建立VLAN 10
　　vlan 20 建立VLAN 20
　　int e1/0/20 进入端口20
　　port access vlan 10 把端口20放入VLAN 10
　　int e1/0/24 进入24端口
　　port link-type trunk 把24端口设为TRUNK端口
　　port trunk permit vlan all (port trunk permit vlan 10 只能为vlan 10使用)24端口为所有VLAN使用
　　sw2:
　　vlan 10
　　int e1/0/5
　　port access vlan 10
　　int e1/0/24
　　port link-type trunk 把24端口设为TRUNK端口
　　port trunk permit vlan all (port trunk permit vlan 10 只能为vlan 10使用)24端口为所有VLAN使用
　　sw1(三层交换机):
　　int vlan 10 创建虚拟接口VLAN 10
　　ip address 192.168.10.254 255.255.255.0 设置虚拟接口VLAN 10的地址
　　int vlan 20 创建虚拟接口VLAN 20
　　ip address 192.168.20.254 255.255.255.0 设置虚拟接口IP VLAN 20的地址
　　注意：vlan 10里的计算机的网关设为 192.168.10.254
　　vlan 20里的计算机的网关设为 192.168.20.254

### 动态路由RIP

　　R1:
　　int e1/0 进入e1/0端口
　　ip address 192.168.3.1 255.255.255.0 设置IP
　　int e2/0 进入e2/0端口
　　ip adress 192.168.5.1 255.255.255.0 设置IP
　　rip 设置动态路由
　　network 192.168.5.0 定义IP
　　network 192.168.3.0 定义IP
　　disp ip rout 查看路由接口
　　R2:
　　int e1/0 进入e1/0端口
　　ip address 192.168.4.1 255.255.255.0 设置IP
　　int e2/0 进入e2/0端口
　　ip adress 192.168.5.2 255.255.255.0 设置IP
　　rip 设置动态路由
　　network 192.168.5.0 定义IP
　　network 192.168.4.0 定义IP
　　disp ip rout 查看路由接口
　　(注意：两台PC机的网关设置PC1 IP：192.168.3.1 PC2 IP：192.168.4.1)

### IP访问列表

　　int e1/0
　　ip address 192.168.3.1 255.255.255.0
　　int e2/0
　　ip address 192.168.1.1 255.255.255.0
　　int e3/0
　　ip address 192.168.2.1 255.255.255.0
　　acl number 2001 (2001-2999属于基本的访问列表)
　　rule 1 deny source 192.168.1.0 0.0.0.255 (拒绝地址192.168.1.0网段的数据通过)
　　rule 2 permit source 192.168.3.0 0.0.0.255(允许地址192.168.3.0网段的数据通过)
　　以下是把访问控制列表在接口下应用：
　　firewall enable
　　firewall default permit
　　int e3/0
　　firewall packet-filter 2001 outbound
　　disp acl 2001 显示信息
　　undo acl number 2001 删除2001控制列表
　　扩展访问控制列表
　　acl number 3001
　　rule deny tcp source 192.168.3.0 0.0.0.255 destination 192.168.2.0 0.0.0.255 destination-port eq ftp
　　必须在r-acl-adv-3001下才能执行
　　rule permit ip source an destination any (rule permit ip)
　　int e3/0
　　firewall enable 开启防火墙
　　firewall packet-filter 3001 inbound
　　必须在端口E3/0下才能执行

### 命令的标准访问IP列表(三层交换机)

　　允许A组机器访问服务器内资料，不允许访问B组机器(服务器没有限制)
　　sys
　　vlan 10
　　name server
　　vlan 20
　　name teacher
　　vlan 30
　　name student
　　int e1/0/5
　　port access vlan 10
　　int e1/0/10
　　port access vlan 20
　　int e1/0/15
　　port access vlan 30
　　int vlan 10
　　ip address 192.168.10.1 255.255.255.0
　　undo sh
　　int vlan 20
　　ip address 192.168.20.1 255.255.255.0
　　int vlan 30
　　ip address 192.168.30.1 255.255.255.0
　　acl number 2001
　　rule 1 deny source 192.168.30.0 0.0.0.255
　　rule 2 permit source any
　　disp acl 2001 查看2001列表
　　int e1/0/10
　　port access vlan 20
　　packet-filter outbound ip-group 2001 rule 1
　　出口

### 允许A机器访问B机器的FTP但不允许访问WWW，C机器没有任何限制。

　　vlan 10
　　vlan 20
　　vlan 30
　　int e1/0/5
　　port access vlan 10
　　int e1/0/10
　　port access vlan 20
　　int e1/0/15
　　port access vlan 30
　　int vlan 10
　　ip address 192.168.10.1 255.255.255.0
　　undo sh
　　int vlan 20
　　ip address 192.168.20.1 255.255.255.0
　　int vlan 30
　　ip address 192.168.30.1 255.255.255.0
　　acl number 3001
　　rule 1 deny tcp source 192.168.30.0 0.0.0.255 destination 192.168.10.0 0.0.0.255 destination-port eq www
　　int e1/0/15
　　packet-filter inbound ip-group 3001 rule 1
　　进口

### NAT地址转换(单一静态一对一地址转换)

　　R1:
　　sys
　　sysname R1
　　int e1/0
　　ip address 192.168.3.1 255.255.255.0
　　int e2/0
　　ip address 192.1.1.1 255.255.255.0
　　R2:
　　sys
　　sysname R2
　　int e2/0
　　ip address 192.1.1.2 255.255.255.0
　　int e1/0
　　ip address 10.80.1.1 255.255.255.0
　　回到R1：
　　nat static 192.168.3.1 192.1.1.1
　　int e2/0
　　nat outbound static
　　ip route 0.0.0.0 0.0.0.0 192.1.1.2

### NAT内部整网段地址转换

　　R1:
　　sys
　　sysname R1
　　int e1/0
　　ip address 192.168.3.1 255.255.255.0
　　int e2/0
　　ip address 192.1.1.1 255.255.255.0
　　acl number 2008
　　rule 0 permit source 192.168.3.0 0.0.0.255
　　rule 1 deny
　　quit
　　int e2/0
　　nat outbound 2008
　　quit
　　ip route-static 0.0.0.0 0.0.0.0 192.1.1.2 preference 60

## SNMP配置

```shell
snmp-agent /使能snmp服务/
snmp-agent local-engineid 000007DB7F000001000049DD /系统自动生成，无需配置/
snmp-agent community read public /设置读团体名:public/
snmp-agent community write private /设置写团体名:private/
snmp-agent sys-info contact Mr.Wang-Tel:3306 /设置联系方式/
snmp-agent sys-info location 3rd-floor /设置设备位置/
snmp-agent sys-info version v1 v3 /配置snmp版本允许V1（默认只允许v3）/
snmp-agent target-host trap address udp-domain 129.102.149.23 udp-port 5000 par
ams securityname public
/允许向网管工作站（NMS）129.102.149.23发送Trap报文，使用的团体名为public/
```

## 问题记录

### Error: Please renew the default configurations

重新配置的时候, 出现这种报错, 需要一层层删除配置, 直到恢复默认配置

配置的时候为

    port link-type access
    port default vlan 4

所以如果出现这种错误，在这里就需要从后往前删除,即

    undo port default vlan 4
    undo port link-type # 或者直接使用 port link-type trunk 修改

到这里以后 才可以重新更改端口的模式。

**或者可以直接清空某个接口的所有配置**

    clear configuration interface GigabitEthernet 0/0/2

再如

    interface GigabitEthernet5/0/15
     port link-type trunk
     port trunk allow-pass vlan 2 to 4094

先执行`undo port trunk allow-pass vlan 2 to 4094`

然后就可以通过`port link-type access`将端口修改为 `access`

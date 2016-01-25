# AC6005

## 配置AP

修改名字

```shell
<AC6005-2>sys
Enter system view, return user view with Ctrl+Z.
[AC6005-2]wlan
[AC6005-2-wlan-view]ap ?
  INTEGER<0-4095>  AP ID
  data-collection  Data-collection
  id               AP ID
  modify           Modify AP
  static-ip        Static IP
[AC6005-2-wlan-view]ap id 21
[AC6005-2-wlan-ap-21]ap-sysname 11F-3
```

### 配置在射频上绑定射频模板和服务集

[参考链接](http://support.huawei.com/ehedex/hdx.do?docid=DOC1000044692&lang=zh&clientWidth=1424&browseTime=1496627036697)

配置更改后,及时生效

```shell
[AC6005-2-wlan-ap-21]ap 21 radio 0

[AC6005-2-wlan-radio-21/1]undo service-set id 6
[AC6005-2-wlan-radio-21/1]undo service-set id 7

[AC6005-2-wlan-radio-21/1]service-set id 1
[AC6005-2-wlan-radio-21/1]service-set id 2
[AC6005-2-wlan-radio-21/1]service-set id 3
[AC6005-2-wlan-radio-21/1]service-set id 4
```

```shell
 ap 1 radio 0
  radio-profile id 0
  channel 20MHz 11
  power-level 30
  service-set id 0 wlan 1
  service-set id 1 wlan 2
  service-set id 2 wlan 3
  service-set id 3 wlan 4
  service-set id 4 wlan 5
  service-set id 5 wlan 6
  service-set id 6 wlan 7
  service-set id 7 wlan 8
  service-set id 8 wlan 9
  service-set id 9 wlan 10
  service-set id 11 wlan 11
 ap 1 radio 1
  radio-profile id 0
  channel 40MHz-plus 157
  power-level 30
  service-set id 0 wlan 1
  service-set id 1 wlan 2
  service-set id 2 wlan 3
  service-set id 3 wlan 4
  service-set id 4 wlan 5
  service-set id 5 wlan 6
  service-set id 6 wlan 7
  service-set id 7 wlan 8
  service-set id 8 wlan 9
  service-set id 9 wlan 10
  service-set id 11 wlan 11
```

## AC开启SNMP

使用 `v2c` 执行 `1234` 步即可

使用如下命令确认设置

    display current-configuration | inc snmp

1. 执行命令 `system-view` ，进入系统视图。

2. （可选）执行命令 `snmp-agent` ，启动SNMP Agent服务。

缺省情况下，没有启动SNMP Agent服务。执行任意snmp-agent的配置命令（无论是否含参数）都可以触发SNMP Agent服务启动，故该步骤可选。

3. 执行命令 `snmp-agent sys-info version v2c` ，配置SNMP的协议版本为SNMPv2c。缺省情况下，使能SNMPv3。

**说明：**

使用SNMPv2c存在安全风险，建议您使用SNMPv3管理设备。

4. 执行命令 `snmp-agent community { read | write } { community-name | cipher community-name }` ，配置设备的读写团体名。

配置设备的读写团体名之后，使用该团体名的网管拥有Viewdefault视图（即1.3.6.1和1.2.840.10006.300.43视图）的权限。如果需要修改该网管的访问权限，请参考（可选）限制网管对设备的管理权限进行配置。

**说明：**

NMS上配置的团体名需和Agent上配置的团体名保持一致，否则NMS将无法访问Agent。

5. 执行命令 `snmp-agent target-host trap-paramsname paramsname v2c securityname securityname [ binding-private-value ] [ private-netmanager ]` ，配置设备发送Trap报文的参数信息。

6. 执行命令 `snmp-agent target-host trap-hostname hostname address { ipv4-addr [ udp-port udp-portid ] | ipv6 ipv6-addr [ udp-port udp-portid ] } trap-paramsname paramsname` ，配置设备发送告警和错误码的目的主机。

请参考下面的说明对参数进行选取：
目的UDP端口号缺省是162，如果有特殊需求（比如避免知名端口号被攻击或者配置了端口镜像），可以配置udp-port将UDP端口号更改为非知名端口号，保证网管和被管理设备的正常通信。

7. （可选）执行命令snmp-agent sys-info { contact contact | location location }，配置设备管理员的联系方式和位置。

缺省情况下，系统维护联系信息为“R&D Shenzhen, Huawei Technologies Co.,Ltd.”，物理位置信息为“Shenzhen China”。
当网管管理多个设备时，为了方便网管管理员记录设备管理员的联系方式和位置，在设备异常时快速联系设备管理员进行故障排除和定位，可配置该功能。

如果需要同时配置设备管理员的联系方式和位置，请执行两次该命令分别配置管理员的联系方式和位置。
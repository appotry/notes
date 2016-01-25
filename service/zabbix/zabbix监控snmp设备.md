# zabbix监控snmp设备

模板

参考zabbix自带模板

[zbx_export_templates-Network Traffic Check By Public Snmp V2](http://oi480zo5x.bkt.clouddn.com/zbx_export_templates-Network%20Traffic%20Check%20By%20Public%20Snmp%20V2.xml)

使用模板的时候需要填写宏, `{$SNMP_COMMUNITY}` 团体名 ->

## 示例:zabbix通过AC自动发现AP,并记录对应AP上连入的用户

AC6005

添加自动发现

`SNMP OID` OID具体参考对应**设备及版本的MIB文档**

    discovery[{#SNMPVALUE},SNMPv2-SMI::enterprises.2011.6.139.2.6.1.1.7]

使用 此SNMP OID `SNMPv2-SMI::enterprises.2011.6.139.2.6.1.1.7`可以列出AC管理的所有AP

![zabbix-snmp-02](http://oi480zo5x.bkt.clouddn.com/zabbix-snmp-02.png)

而后将此`SNMPINDEX`用于其他的 `SNMP OID`

监控项原型

![zabbix-snmp-01](http://oi480zo5x.bkt.clouddn.com/zabbix-snmp-01.png)

另外可根据需求添加触发器类型,以及图形原型

## zabbix监控snmp问题记录

网页提示无法解析OID

查看zabbix_server日志,详细内容如下:

```shell
...
      7147:20170505:144603.955 item "s5700_172.16.1.254:ifOutOctets[1,2]" became not supported: snmp_parse_oid(): cannot parse OID "IF-MIB::ifOutOctets.26".
      7147:20170505:144703.978 item "s5700_172.16.1.254:sysUpTime" became not supported: snmp_parse_oid(): cannot parse OID "SNMPv2-MIB::sysUpTime.0".
...
```

解决办法:

安装 `snmp-mibs-downloader`

    root@ubuntu-server04:~# apt-get install snmp-mibs-downloader
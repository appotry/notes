OID获取
=======

http://www.mamicode.com/info-detail-1391074.html

华为
----

S5700-28C-EI

找到对应版本号

V200R003C00SPC300

.. figure:: http://oi480zo5x.bkt.clouddn.com/S5700-01.png
   :alt: S5700-01

   S5700-01

将下载的MIB
库解压后打开，找到HUAWEI-CPU-MIB中的详细描述，找到OID的前缀为
1.3.6.1.4.1.2011.6.3.4.1.1

思科
----

要监控交换机的端口流量、状态，CPU使用率，内存状态，温度等，关键是找出与之相对应的OID，本文将与大家探讨怎么样获取思科及华为交换机的OID，方法是一样的，大家可以举一反三。

一、思科OID的获取

https://www.cisco.com/c/en/us/support/web/tools-catalog.html

1. 找到MIB Locator，并点进去

.. figure:: http://oi480zo5x.bkt.clouddn.com/Cisco-MIB.png
   :alt: Cisco-MIB

   Cisco-MIB

2. 选择SNMP Object Navigator这一项，并登陆思科账号

3. 在SNMP Object Navigator里，选择MIB SUPPORT-SW ，将要查找OID
   的交换机的IOS
   名称填写进image-name框中，点击search,会出来交换机所有的MIB 库

4. 根据所使用的snmp版本选择对应的v1或v2，查找相对应的OID
   库，这里我以环境OID 为例。

5. 找到CISCO-ENVMON-MIB，点击后面的V2

6. 按CTRL+F，查找Temperature,copy
   ciscoEnvMonTemperatureStatusValue，注意要找值一定是在OBJECT-TYPE前面

7. 在SNMP Object
   Navigator里，选择TRANSLATE/BROWSE，将刚刚复制的值粘贴到object
   name里面，点击Translate，得出相应的OID值为1.3.6.1.4.1.9.9.13.1.3.1.3

8. 在linux系统中使用snmpwalk命令获取OID的全值，上一步获取的只是OID的一部分。

   命令：snmpwalk -v 2c -c snmp-ready-value ip
   .1.3.6.1.4.1.9.9.13.1.3.1.3，得到的完全OID为1.3.6.1.4.1.9.9.13.1.3.1.3.1008

   1.3.6.1.4.1.9.9.13.1.3.1.3前面加一“.”或不加，效果是一样的。
   从snmpwalk命令获取的信息可以知道，该交换机的温度为39度，可以到交换机上用命令show
   env temperature status核对

   可以随便找一个交换机的IOS来试试找一下CPU跟内存，看跟我找的是不是一样的。

   .1.3.6.1.4.1.9.9.48.1.1.1.6.1 ciscoMemoryPoolFree

   .1.3.6.1.4.1.9.9.48.1.1.1.5.1 ciscoMemoryPoolUsed

   .1.3.6.1.4.1.9.2.1.57.0 CPU utilization for one minute

   .1.3.6.1.4.1.9.2.1.58.0 CPU utilization for five minutes

   .1.3.6.1.4.1.9.2.1.56.0 CPU utilization for five seconds

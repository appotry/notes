snmpwalk使用
============

Ubuntu如果没有安装snmp没有这个命令

::

    apt-get install snmp

类RHEL系统

::

    yum install net-snmp-utils

    snmpwalk -v 2c -c public localhost .1.3.6.1.4.1.2011.6.3.4.1.2

    snmpwalk -v 2c -c xxx-public IP .1.3.6.1.2.1.2.2.1.2

public为团体名,需要在设备上配置

# Zabbix告警记录

## Zabbix poller processes more than 75% busy

可能原因,zabbix_server不断轮训agent,向agent提取数据,所以报如上错误

解决办法,agent主动将值发送给server

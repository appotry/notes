# tomcat

## tomcat监控

在Zabbix中，JMX监控数据的获取由专门的代理程序来实现,即`Zabbix-Java-Gateway`来负责数据的采集，`Zabbix-Java-Gateway`和`JMX`的`Java`程序之间通信获取数据

### JMX在Zabbix中的运行流程

```txt
1. Zabbix-Server找Zabbix-Java-Gateway获取Java数据
2. Zabbix-Java-Gateway找Java程序(zabbix-agent)获取数据
3. Java程序返回数据给Zabbix-Java-Gateway
4. Zabbix-Java-Gateway返回数据给Zabbix-Server
5. Zabbix-Server进行数据展示
```

### 配置JMX监控的步骤

```txt
1. 安装Zabbix-Java-Gateway。
2. 配置zabbix_java_gateway.conf参数。
3. 配置zabbix-server.conf参数。
4. Tomcat应用开启JMX协议。
5. ZabbixWeb配置JMX监控的Java应用。
```

### 1.配置所有Agent(标准化目录结构)

```shell
vim /etc/zabbix/zabbix_agentd.conf #编辑配置文件引用key
    Include=/etc/zabbix/zabbix_agentd.d/*.conf

mkdir /etc/zabbix/scripts #存放Shell脚本
```

### 2.安装java以及zabbix-java-gateway (如果源码安装加上--enable-java参数)

```shell
yum install  zabbix-java-gateway java-1.8.0-openjdk -y
```

### 3.启动zabbix-java-gateway

```shell
systemctl start zabbix-java-gateway

netstat -lntup|grep 10052
tcp6       0      0 :::10052                :::*                    LISTEN      13042/java
```

4.修改zabbix-server 配置文件

```shell
vim /etc/zabbix/zabbix_server.conf
    JavaGateway=192.168.90.11  # java gateway地址(如果和zabbix-server装一起可以写127.0.0.1)
    JavaGatewayPort=10052  #java gateway端口,默认端口10052
    StartJavaPollers=5  #启动进程轮询java gateway
```

5.重启zabbix-server

```shell
systemctl restart zabbix-server
```

6.开启tomcat的远程jvm配置文件

```shell
vim /usr/local/tomcat/bin/catalina.sh  #找到自己本机tomcat路径(如果是salt来管,修改salt模板即可)
    CATALINA_OPTS="$CATALINA_OPTS
    -Dcom.sun.management.jmxremote
    -Dcom.sun.management.jmxremote.port=12345
    -Dcom.sun.management.jmxremote.authenticate=false
    -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=192.168.90.11"

#远程jvm配置文件解释

    CATALINA_OPTS="$CATALINA_OPTS
    -Dcom.sun.management.jmxremote # #启用远程监控JMX
    -Dcom.sun.management.jmxremote.port=12345 #jmx远程端口,Zabbix添加时必须一致
    -Dcom.sun.management.jmxremote.authenticate=false #不开启用户密码认证
    -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=192.168.90.11" #运行tomcat服务IP(不要填写错了)
```

7.重启tomcat服务

```shell
/usr/local/tomcat/bin/shutdown.sh
/usr/local/tomcat/bin/startup.sh
```

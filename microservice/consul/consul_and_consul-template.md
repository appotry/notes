# 搭建consul

**仅供参考**

<!-- TOC -->

- [搭建consul](#搭建consul)
    - [1 规划](#1-规划)
    - [2 安装consul](#2-安装consul)
    - [3 2.199安装consul-template](#3-2199安装consul-template)
    - [4 每台机器配置](#4-每台机器配置)
        - [4.1 2.6](#41-26)
        - [4.2 2.3](#42-23)
        - [4.3 2.4](#43-24)
        - [4.4 2.5](#44-25)
        - [4.5 2.18](#45-218)
        - [4.6 2.19](#46-219)
        - [4.7 2.198](#47-2198)
        - [4.8 2.199](#48-2199)
    - [5 启动脚本](#5-启动脚本)
        - [5.1 consul启动脚本](#51-consul启动脚本)
        - [5.2 consul-template脚本](#52-consul-template脚本)
        - [consul-template配置案列](#consul-template配置案列)
    - [6 consul使用](#6-consul使用)

<!-- /TOC -->

## 1 规划

| IP  | 角色 |系统|
|---- |----- |---|
|2.6  |bootstrap|CentOS 6.8|
|2.3  |server   |windows xp|
|2.4  |server   |CentOS 6.6|
|2.5  |client   |CentOS 6.6|
|2.18 |client   |CentOS 6.8|
|2.19 |client   |CentOS 6.8|
|2.198|client   |CentOS 6.8|
|2.199|client   |CentOS 6.8|

## 2 安装consul

> **所有机器执行以下命令**

```shell
# mkdir -p /data/program/consul
# cd /data/program/consul
# ll consul*
-rw-r--r--+ 1 root root 6.2M 10月 27 11:38 consul_0.7.0_linux_amd64.zip
# unzip consul_0.7.0_linux_amd64.zip
# echo "export PATH=$PATH:/data/program/consul" >>/etc/profile
# source /etc/profile
# which consul
/data/program/consul/consul
```

[参考: 官网安装](https://www.consul.io/intro/getting-started/install.html)

## 3 2.199安装consul-template

```shell
# cd /data/program/consul
# ls
consul  consul_0.7.0_linux_amd64.zip  consul-template_0.16.0_linux_amd64.zip
# unzip consul-template_0.16.0_linux_amd64.zip
# ll
总用量 42804
-rwxr-xr-x 1 root root 24003648 9月  15 00:16 consul
-rw-r--r-- 1 root root  6470848 10月 27 11:38 consul_0.7.0_linux_amd64.zip
-rwxr-xr-x 1 root root 10128479 9月  23 06:24 consul-template
-rw-r--r-- 1 root root  3219587 9月  23 06:27 consul-template_0.16.0_linux_amd64.zip

# cp consul-template /usr/bin
# which consul-template
/usr/bin/consul-template
```

## 4 每台机器配置

### 4.1 2.6

```shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/bootstrap/config.json
{
    "bootstrap": true,
    "server": true,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "bs2-6",
    "bind_addr": "192.168.2.6",
    "client_addr": "0.0.0.0",
    "ui": true,
    "log_level": "INFO",
    "enable_syslog": true,
    "retry_join": ["192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld_bs
# chmod 755 /etc/init.d/consuld_bs
```

### 4.2 2.3

### 4.3 2.4

```shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/server/config.json
{
    "bootstrap": false,
    "server": true,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "s2-4",
    "bind_addr": "192.168.2.4",
    "client_addr": "0.0.0.0",
    "ui": true,
    "log_level": "INFO",
    "enable_syslog": true,
    "retry_join": ["192.168.2.6","192.168.2.3"]
}

# vim /etc/init.d/consuld_s
# chmod 755 /etc/init.d/consuld_s
```

### 4.4 2.5

``` shell
2.5
# mkdir -p /etc/consul.d/{bootstrap,server,client}
# cat /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "c2-5",
    "bind_addr": "192.168.2.5",
    "log_level": "INFO",
    "enable_syslog": true,
    "start_join": ["192.168.2.6","192.168.2.3","192.168.2.4"],
    "retry_join": ["192.168.2.6","192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld
# chmod 755 /etc/init.d/consuld
```

### 4.5 2.18

```shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "c2-18",
    "bind_addr": "192.168.2.18",
    "log_level": "INFO",
    "enable_syslog": true,
    "start_join": ["192.168.2.6","192.168.2.3","192.168.2.4"],
    "retry_join": ["192.168.2.6","192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld
# chmod 755 /etc/init.d/consuld
```

### 4.6 2.19

``` shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "c2-19",
    "bind_addr": "192.168.2.19",
    "client_addr": "0.0.0.0",
    "log_level": "INFO",
    "enable_syslog": true,
    "start_join": ["192.168.2.6","192.168.2.3","192.168.2.4"],
    "retry_join": ["192.168.2.6","192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld
# chmod 755 /etc/init.d/consuld
```

### 4.7 2.198

```shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "c2-198",
    "bind_addr": "192.168.2.198",
    "log_level": "INFO",
    "enable_syslog": true,
    "start_join": ["192.168.2.6","192.168.2.3","192.168.2.4"],
    "retry_join": ["192.168.2.6","192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld
# chmod 755 /etc/init.d/consuld
```

### 4.8 2.199

```shell
# mkdir -p /etc/consul.d/{bootstrap,server,client}

# cat /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "jiuge-01",
    "data_dir": "/data/program/consul/consul_data",
    "node_name": "c2-199",
    "bind_addr": "192.168.2.199",
    "log_level": "INFO",
    "enable_syslog": true,
    "start_join": ["192.168.2.6","192.168.2.3","192.168.2.4"],
    "retry_join": ["192.168.2.6","192.168.2.3","192.168.2.4"]
}

# vim /etc/init.d/consuld
# chmod 755 /etc/init.d/consuld
```

> 参考

- [服务发现系统consul--配置](http://www.tuicool.com/articles/EzE7NfY)
- [How to Configure Consul in a Production Environment on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-configure-consul-in-a-production-environment-on-ubuntu-14-04)

## 5 启动脚本

### 5.1 consul启动脚本

```shell
# cat /etc/init.d/consuld
#!/bin/bash
#
# consul        Manage the consul agent
#
# chkconfig:   2345 95 5
# description: Consul is a tool for service discovery and configuration
# processname: consul
# config: /etc/consul.conf
# pidfile: /var/run/consul.pid

### BEGIN INIT INFO
# Provides:       consul
# Required-Start: $local_fs $network
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start: 2 3 4 5
# Default-Stop:  0 1 6
# Short-Description: Manage the consul agent
# Description: Consul is a tool for service discovery and configuration
### END INIT INFO

# source function library
. /etc/rc.d/init.d/functions

prog="consul"
user="consul"
exec="/data/program/consul/$prog"
pidfile="/var/run/$prog.pid"
lockfile="/var/lock/subsys/$prog"
logfile="/var/log/$prog.log"
confdir="/etc/consul.d/client"

# pull in sysconfig settings


start() {
    [ -x $exec ] || exit 5

    [ -d $confdir ] || exit 6

    umask 077

    touch $logfile $pidfile

    echo -n $"Starting $prog: "

    ## holy shell shenanigans, batman!
    ## daemon can't be backgrounded.  we need the pid of the spawned process,
    ## which is actually done via runuser thanks to --user.  you can't do "cmd
    ## &; action" but you can do "{cmd &}; action".
    daemon \
        --pidfile=$pidfile \
        " { $exec agent -config-dir=$confdir &>> $logfile & } ; echo \$! >| $pidfile "

    RETVAL=$?
    echo

    [ $RETVAL -eq 0 ] && touch $lockfile

    return $RETVAL
}

stop() {
    echo -n $"Shutting down $prog: "
    ## graceful shutdown with SIGINT
    killproc -p $pidfile $exec -INT
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f $lockfile
    return $RETVAL
}

restart() {
    stop
    sleep 2
    start
}

reload() {
    echo -n $"Reloading $prog: "
    killproc -p $pidfile $exec -HUP
    echo
}

force_reload() {
    restart
}

rh_status() {
    status -p "$pidfile" -l $prog $exec
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    force-reload)
        force_reload
        ;;
    status)
        rh_status
        ;;
    condrestart|try-restart)
        rh_status_q || exit 0
        restart
        ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload}"
        exit 2
esac

exit $?
```

参考

- [consul启动脚本github地址](https://gist.github.com/blalor/c325d500818361e28daf)

### 5.2 consul-template脚本

```shell
# cat /etc/init.d/consul-templated
#!/bin/sh
#
# consul-template - this script manages the consul-template
#
# chkconfig:   345 97 03
# processname: consul-template

### BEGIN INIT INFO
# Provides:       consul-template
# Required-Start: $local_fs $network
# Required-Stop:  $local_fs $network
# Default-Start: 3 4 5
# Default-Stop:  0 1 2 6
# Short-Description: Manage the vault server
### END INIT INFO

# Source function library.
. /etc/rc.d/init.d/functions

if [ -L $0 ]; then
    initscript=`/bin/readlink -f $0`
else
    initscript=$0
fi


exec="/bin/consul-template"
prog=`/bin/basename $exec`
conffile="/etc/consul.d/consul_template/consul_template.conf"
lockfile="/var/lock/subsys/${prog}"
logfile="/var/log/${prog}.log"
pidfile="/var/run/${prog}.pid"

RETVAL=0

start() {
    [ -x $exec ] || exit 5
    [ -f $conffile ] || exit 6

    echo -n $"Starting $prog: "
    /bin/touch $logfile
    $exec -pid-file=$pidfile -config=$conffile &>> $logfile  &
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch ${lockfile}
    return $RETVAL
}


stop() {
    echo -n $"Stopping $prog: "
    killproc -p $pidfile $exec 2>>$logfile
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfile} ${pidfile}
    return $RETVAL
}

restart() {
    stop
    sleep 2
    start
}

reload() {
    echo -n $"Reloading $prog: "
    killproc -p $pidfile $exec -HUP
    RETVAL=$?
    echo
}

force_reload() {
    restart
}

configtest() {
    if [ "$#" -ne 0 ] ; then
        case "$1" in
            -q)
                FLAG=$1
                ;;
            *)
                ;;
        esac
        shift
    fi
    ${exec} -dry -config=${conffile}  $FLAG
    RETVAL=$?
    return $RETVAL
}

rh_status() {
    status $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

# See how we were called.
case "$1" in
    start)
        rh_status >/dev/null 2>&1 && exit 0
        start
        ;;
    stop)
        stop
        ;;
    status)
        rh_status
        RETVAL=$?
        ;;
    restart)
        restart
        ;;
    reload)
        reload
        ;;
    configtest)
        configtest
        ;;
    *)
        echo $"Usage: $prog {start|stop|restart|reload|status|configtest}"
        RETVAL=2
esac

exit $RETVAL
```

### consul-template配置案列

```shell
# tree /etc/consul.d/consul_template/
├── consul_template.conf
├── consul_template.conf.example
└── weixin-server.ctmpl

# cat /etc/consul.d/consul_template/weixin-server.ctmpl
upstream weixinHost {
  {{range service "weixin-server"}}
  server {{.Address}}:{{.Port}};
  {{end}}
}

server {
  listen 80;
  server_name test118;
  location /weixin  {
  proxy_pass http://weixinHost/weixin/server;
  }
  }

# cat /etc/consul.d/consul_template/consul_template.conf
reload_signal = "SIGHUP"
dump_signal = "SIGQUIT"
kill_signal = "SIGINT"
retry = "10s"
max_stale = "10m"
log_level = "debug"
pid_file = "/var/run/consul-template.pid"
wait = "5s:10s"
template {
  source = "/etc/consul.d/consul_template/weixin-server.ctmpl"
  destination = "/etc/nginx/conf.d/weixin.conf"
  command = "service nginx reload || true"
  perms = 0644
  backup = true
  left_delimiter  = "{{"
  right_delimiter = "}}"

  wait = "2s:6s"
}
```

参考

- [consul-template搭建部署](https://github.com/hashicorp/consul-template)
- [consul-template启动脚本](https://gist.github.com/yunano/4140341d4f0be9fd1e8f)

## 6 consul使用

```shell
#查看集群节点详细情况
# consul members

#离开集群
# consul leave

#强制离开集群
# consul force-leave c27

#通过api查看节点详细情况
# curl http://192.168.11.46:8500/v1/catalog/nodes\?pretty

#通过api删除节点
# curl -X PUT http://192.168.11.46:8500/v1/agent/force-leave/c27
```

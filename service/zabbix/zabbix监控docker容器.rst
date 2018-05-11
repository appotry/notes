Docker容器监控
==============

步骤:

1. zabbix-agent 加载 ``zabbix_module_docker.so``
   模块(配置之后,重启zabbix-agent)
2. 导入模块,添加主机

监控方案
--------

使用
`zabbix-docker-monitoring <https://github.com/monitoringartist/zabbix-docker-monitoring>`__
插件。

`容器监控参考 <https://segmentfault.com/a/1190000007568413>`__

**gh-pages有已经编译好的so文件,可以直接使用**

项目用来持续集成的脚本思路,可以学习

配置服务端

Zabbix 是 C/S 架构，服务端最好能配置在一台独立的宿主机上。

服务端 docker-compose 文件：

.. code:: yml

    version:'2'
      services:
        zabbix:image: monitoringartist/zabbix-xxl
          ports:
            - 8080:80
            - 10051:10051
          volumes:
            - /etc/localtime:/etc/localtime:ro
          depends_on:
            - zabbix.db
          environment:
            ZS_DBHost: zabbix.db
            ZS_DBUser: zabbix
            ZS_DBPassword: zabbix_password
        zabbix.db:
          image: monitoringartist/zabbix-db-mariadb
          volumes:
            - /backups:/backups
            - /etc/localtime:/etc/localtime:rovolumes_from:
            - zabbix-db-storage
          environment:
            MARIADB_USER: zabbix
            MARIADB_PASS: zabbix_password
        zabbix-db-storage:
          image: busybox:latest
          volumes:
            - /var/lib/mysql

容器方式运行 Zabbix-agent

可以无需在宿主机安装 Zabbix-agent，直接运行官方的容器即可。

运行 Zabbix-agent 容器：

.. code:: shell

    docker run \
      --name=zabbix-agent-xxl \
        -h $(hostname) \
        -p 10050:10050 \
        -v /:/rootfs \
        -v /var/run:/var/run \
        -e"ZA_Server=" \
        -d monitoringartist/zabbix-agent-xxl-limited:latest

配置容器

-  修改 ZA_Server，直接改成服务器 ip。

如果想覆盖容器中 agent 的配置变量，可以在 run 的时候使用
``-e ZA_Variable=value`` 的方法，但是对 AllowRoot, LoadModulePath,
LoadModule, LogType 的配置无法覆盖，其中 AllowRoot 的默认值就是 1，参看
Github Issue。

宿主机直接运行 Zabbix-agent
---------------------------

容器的方式运行 ``zabbix-agent`` 不支持 ``docker.xnet``
数据的监控，想要监控 ``docker.xnet`` 数据，得直接在宿主机上运行
``zabbix-agent``\ ，并加载 ``zabbix_module_docker.so``\ ，\ `参看 Github
Issue <https://github.com/monitoringartist/dockbix-agent-xxl/issues/17>`__\ 。

1. 添加 zabbix 用户和组

   groupadd zabbix useradd -g zabbix zabbix

2. 安装 zabbix-agent

3. 下载或编译 zabbix_module_docker.so:

4. 启动 zabbix_agentd

使用 systemd 管理进程，关于 systemd `参考
阮一峰的网络日志 <http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html>`__

创建 ``/lib/systemd/system/zabbix-agentd.service`` 文件：

.. code:: shell

    [Unit]
    Description=Zabbix Agent
    After=syslog.target
    After=network.target

    [Service]
    Environment="CONFFILE=/usr/local/etc/zabbix_agentd.conf"
    Type=forking
    Restart=on-failure
    PIDFile=/tmp/zabbix_agentd.pid
    KillMode=control-group
    ExecStart=/usr/local/sbin/zabbix_agentd -c $CONFFILE
    ExecStop=/bin/kill -SIGTERM $MAINPID
    RestartSec=10s

    [Install]
    WantedBy=multi-user.target

执行下面命令告知 systemctl 如何启动 zabbix-agentd

::

    sudo systemctl enable zabbix-agentd.service

5. 配置加载项

修改 zabbix-agentd 配置文件 ``/usr/local/etc/zabbix_agentd.conf``
中的下面几个参数:

.. code:: shell

    Server=Zabbix-Server-IP
    ServerActive=Zabbix-Server-IP
    Hostname=Current-Host-Name
    Timeout=30
    # 目录可以自行设定 注意属主及属组
    LoadModulePath=/usr/lib/zabbix/agent
    LoadModule=zabbix_module_docker.so

运行下面命令启动 zabbix-agentd

::

    systemctl start zabbix-agentd.service

6. 启动失败分析

-  如果启动失败，查看日志

报错：

.. code:: bash

    zabbix_agentd [xxxxx]: cannot attach to existing shared memory: [13] Permission denied
    cannot allocate shared memory for collector

可能是 zabbix_module_docker.so 编译错误，重新编译一次即可。

设置监控

导入模板

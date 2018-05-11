Tomcat日志切割
==============

环境
----

.. code:: bash

    [root@server /opt/apache-tomcat-icbc/bin]# sh version.sh
    Using CATALINA_BASE:   /opt/apache-tomcat-icbc
    Using CATALINA_HOME:   /opt/apache-tomcat-icbc
    Using CATALINA_TMPDIR: /opt/apache-tomcat-icbc/temp
    Using JRE_HOME:        /usr
    Using CLASSPATH:       /opt/apache-tomcat-icbc/bin/bootstrap.jar:/opt/apache-tomcat-icbc/bin/tomcat-juli.jar
    Server version: Apache Tomcat/7.0.57
    Server built:   Nov 3 2014 08:39:16 UTC
    Server number:  7.0.57.0
    OS Name:        Linux
    OS Version:     2.6.32-504.el6.x86_64
    Architecture:   amd64
    JVM Version:    1.7.0_71-b14
    JVM Vendor:     Oracle Corporation

案例
----

.. code:: bash

    [root@server /opt/apache-tomcat-icbc/logs]# du -sh catalina.out
    210M    catalina.out

解决
----

.. code:: bash

    # 1. 安装cronolog
    [root@server ~]#yum –y install cronolog
    [root@server ~]# which cronolog
    /usr/sbin/cronolog

    # 2. 修改bin/catalina.sh

        # 1. 找到下面行并把它用#注释掉
        touch "$CATALINA_OUT"

        # 2. 替换下面的行(有两处，不过一般在 -security 中的那一行不需要去关注，不妨两处全替换了)
        >> "$CATALINA_OUT" 2>&1 "&"
        替换为
        2>&1 |/usr/sbin/cronolog "$CATALINA_BASE/logs/catalina-%Y-%m-%d.out" &

    # 3. 重启tomcat
    [root@server /opt/apache-tomcat-icbc/bin]#sh shutdown.sh
    [root@server /opt/apache-tomcat-icbc/bin]#sh startup.sh

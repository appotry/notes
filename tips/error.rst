故障集锦
========

能连上机房主机，但是执行命令卡
------------------------------

背景：今早用xshell连上线上机器查看日志，能够连接上主机，但是执行命令卡，比如top、ll等命令卡，于是就开始排查，开始以为是工具问题，于是乎就重新安装了xshell，还是一样，另外使用了babun，CRT等远程连接工具，还是一样的效果。用crtl
+ c也结束不了。以下是效果图：

.. code:: bash

    Connecting to 192.168.2.18:1898...
    Connection established.
    To escape to local shell, press 'Ctrl+Alt+]'.

    Last login: Sat Jan  7 11:55:54 2017 from 192.168.3.2

    root@BJJGSERVER7: ~
    # top

网上搜索一两个小时无果，于是请教总监，说了句应该是win mtu值导致的

.. code:: bash

    Microsoft Windows [版本 10.0.14393]
    (c) 2016 Microsoft Corporation。保留所有权利。

    C:\WINDOWS\system32>netsh interface ipv4 show subinterfaces

       MTU  MediaSenseState   传入字节  传出字节      接口
    ------  ---------------  ---------  ---------  -------------
    4294967295                1          0    1043428  Loopback Pseudo-Interface 1
      1500                5          0          0  蓝牙网络连接 2
      1500                1  5332716443  335378834  WLAN 2
      1500                5          0          0  以太网 2
      1500                5          0          0  本地连接* 7
      1500                5          0          0  本地连接* 8
      1500                1       3936     114097  以太网 3
      1500                1          0     101166  以太网 4

    C:\WINDOWS\system32>netsh interface ipv4 set subinterface "WLAN 2" mtu=1380 store=persistent
    确定。

    C:\WINDOWS\system32>netsh interface ipv4 show subinterfaces

       MTU  MediaSenseState   传入字节  传出字节      接口
    ------  ---------------  ---------  ---------  -------------
    4294967295                1          0    1043428  Loopback Pseudo-Interface 1
      1500                5          0          0  蓝牙网络连接 2
      1380                1  5333274289  335543910  WLAN 2
      1500                5          0          0  以太网 2
      1500                5          0          0  本地连接* 7
      1500                5          0          0  本地连接* 8
      1500                1       3936     114901  以太网 3
      1500                1          0     101970  以太网 4

Zabbix报警Lack of free swap space
---------------------------------

报警显示swap不够，是因为重新部署了几个java程序，然后立马把程序放在其他机器，报警几天还是持续有，因为太多程序，所以机器尽量不重启，然后需要分析那些程序占用swap，然后重启程序即可，报警详细截图如下

以下是脚本是分析占用swap最多的程序的前十个程序

.. code:: bash

     [root@server198 ~]# cat swap.sh
    #!/bin/bash
    function swapoccupancy ()
    {
        echo -e "Pid\tSwap\tProgame"
        num=0
        for pid in `ls -1 /proc|egrep "^[0-9]"`
        do
            if [[ $pid -lt 20 ]]
            then
                continue
            fi
            program=`ps -eo pid,command|grep -w $pid|grep -v grep|awk '{print $2}'`
            for swap in `grep Swap /proc/$pid/smaps 2>/dev/null|awk '{print $2}'`
            do
                let num=$num+$swap
            done
            echo -e "${pid}\t${num}\t${program}"
            num=0
        done|sort -nrk2|head
    }
    swapoccupancy
    exit 0

然后执行脚本，可能会导致机器负载升高，取决于机器运行的程序多少，以下是运行结果

.. code:: bash

    [root@server198 ~]# sh swap.sh
    Pid Swap    Progame
    8807    1972956 /data/app/java/bin/java
    8884    1117536 /data/app/java/bin/java
    8091    486644  /usr/bin/mongod
    11231   320180  /data/app/java/bin/java
    11869   279472  /data/app/java/bin/java
    38591   196480  java
    41480   156956  /data/app/java/bin/java
    18973   99272   /data/app/java/bin/java
    23299   67280   /data/app/java/bin/java
    38729   64384   java

然后根据程序pid查看对应的进程，挑选个合适的时间重启服务，把脚本执行的复制到文本，用for循环打印出对应的程序

.. code:: bash

    [root@server198 ~]# vim swap_program.txt
    [root@server198 ~]# cat swap_program.txt
    Pid Swap    Progame
    8807    1972956 /data/app/java/bin/java
    8884    1117536 /data/app/java/bin/java
    8091    486644  /usr/bin/mongod
    11231   320180  /data/app/java/bin/java
    11869   279472  /data/app/java/bin/java
    38591   196480  java
    41480   156956  /data/app/java/bin/java
    18973   99272   /data/app/java/bin/java
    23299   67280   /data/app/java/bin/java
    38729   64384   java

    [root@server198 ~]# cat swap_program.txt|sed '1d'|awk '{print $1}'
    8807
    8884
    8091
    11231
    11869
    38591
    41480
    18973
    23299
    38729
    [root@server198 ~]# for n in $(cat swap_program.txt|sed '1d'|awk '{print $1}');do ps -ef|grep $n|grep -v grep;done

参考

-  `shell分析swap分区被哪些程序占用(stress模拟环境) <http://7938217.blog.51cto.com/7928217/1653649>`__
-  `CENTOS6.5释放SWAP <http://www.centoscn.com/CentOS/help/2015/0206/4641.html>`__
-  `Linux下swap耗尽该怎么办？如何释放swap？ <http://www.jb51.net/LINUXjishu/309129.html>`__
-  `CentOS下SWAP分区建立及释放内存 <http://sundful.iteye.com/blog/2277173>`__
-  `Centos6
   物理内存还剩1G，swap虚拟内存已经被使用 <http://davidbj.blog.51cto.com/4159484/1172879/>`__
-  `CentOS下清理swap和buffer/cache <http://www.centoscn.com/CentOS/Intermediate/2014/0113/2356.html>`__

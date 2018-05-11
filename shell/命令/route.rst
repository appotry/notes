route
=====

    route - show / manipulate the IP routing table This program is
    obsolete. For replacement check **ip route**.

常用参数
--------

.. code:: bash

    -n     show numerical addresses instead of trying to determine symbolic host names. This is useful  if  you  are
           trying to determine why the route to your nameserver has vanished.

    del    delete a route.

    add    add a new route.
    target the destination network or host. You can provide IP addresses in dotted decimal or host/network names.

    -net   the target is a network.
    -host  the target is a host.
    netmask NM
           when adding a network route, the netmask to be used.

    gw GW  route packets via a gateway.  NOTE: The specified gateway must be reachable  first.  This  usually  means
           that  you  have  to set up a static route to the gateway beforehand. If you specify the address of one of
           your local interfaces, it will be used to decide about the interface  to  which  the  packets  should  be
           routed to. This is a BSDism compatibility hack.

    dev If force the route to be associated with the specified device, as the kernel will otherwise try to determine
           the device on its own (by checking already existing routes and device specifications, and where the route
           is added to). In most normal networks you won’t need this.

           If dev If is the last option on the command line, the word dev may be omitted, as it’s the default.  Oth-
           erwise the order of the route modifiers (metric - netmask - gw - dev) doesn’t matter.

EXAMPLES
--------

.. code:: bash

    route add -net 127.0.0.0
           adds  the  normal  loopback  entry, using netmask 255.0.0.0 (class A net, determined from the destination
           address) and associated with the "lo" device (assuming this device was prviously set  up  correctly  with
           ifconfig(8)).

    route add -net 192.56.76.0 netmask 255.255.255.0 dev eth0
           adds  a route to the network 192.56.76.x via "eth0". The Class C netmask modifier is not really necessary
           here because 192.* is a Class C IP address. The word "dev" can be omitted here.

    route add default gw mango-gw
           adds a default route (which will be used if no other route matches).  All packets using this  route  will
           be  gatewayed through "mango-gw". The device which will actually be used for that route depends on how we
           can reach "mango-gw" - the static route to "mango-gw" will have to be set up before.

    route add ipx4 sl0
           Adds the route to the "ipx4" host via the SLIP interface (assuming that "ipx4" is the SLIP host).

    route add -net 192.57.66.0 netmask 255.255.255.0 gw ipx4
           This command adds the net "192.57.66.x" to be gatewayed through the former route to the SLIP interface.

    route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0
           This is an obscure one documented so people know how to do it. This sets all of the class  D  (multicast)
           IP routes to go via "eth0". This is the correct normal configuration line with a multicasting kernel.

    route add -net 10.0.0.0 netmask 255.0.0.0 reject
           This installs a rejecting route for the private network "10.x.x.x."

OUTPUT
------

.. code:: bash

    [root@centos ~]# route -n    ## netstat -rn也可以查看路由
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    10.0.0.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
    172.16.1.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
    169.254.0.0     0.0.0.0         255.255.0.0     U     1002   0        0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U     1003   0        0 eth1
    0.0.0.0         10.0.0.2        0.0.0.0         UG    0      0        0 eth0
    #最后一行表示系统的默认网关信息，去任何地方（0.0.0.0），都发给10.0.0.2，因为是默认网关，所以，放在了最后一条。
    #路由也是有顺序的，如果不符合任何一条规则就交给默认网关处理。

    OUTPUT
           The output of the kernel routing table is organized in the following columns

           Destination
                  The destination network or destination host.

           Gateway
                  The gateway address or ’*’ if none set.

           Genmask
                  The  netmask  for  the  destination  net;  ’255.255.255.255’ for a host destination and ’0.0.0.0’ for the
                  default route.

           Flags  Possible flags include
                  U (route is up)
                  H (target is a host)
                  G (use gateway)
                  R (reinstate route for dynamic routing)
                  D (dynamically installed by daemon or redirect)
                  M (modified from routing daemon or redirect)
                  A (installed by addrconf)
                  C (cache entry)
                  !  (reject route)

           Metric The ’distance’ to the target (usually counted in hops). It is not used by  recent  kernels,  but  may  be
                  needed by routing daemons.

           Ref    Number of references to this route. (Not used in the Linux kernel.)

           Use    Count of lookups for the route.  Depending on the use of -F and -C this will be either route cache misses
                  (-F) or hits (-C).

           Iface  Interface to which packets for this route will be sent.

           MSS    Default maximum segement size for TCP connections over this route.

           Window Default window size for TCP connections over this route.

           irtt   Initial RTT (Round Trip Time). The kernel uses this to guess about the best TCP protocol parameters with-
                  out waiting on (possibly slow) answers.

           HH (cached only)
                  The number of ARP entries and cached routes that refer to the hardware header cache for the cached route.
                  This will be -1 if a hardware address is not needed for the interface of the cached route (e.g. lo).

           Arp (cached only)
                  Whether or not the hardware address for the cached route is up to date.

FILES
-----

.. code:: bash

    /proc/net/ipv6_route
    /proc/net/route
    /proc/net/rt_cache

默认路由、网络路由及主机路由
----------------------------

.. code:: bash

    默认路由
        默认网关就是数据包不匹配任何设定的路由规则，最后匹配的路由规则。

    网络路由
        即去往某一网络或网段的路由
        一般多网段之间互相通信，希望建立一条优先路由，而不是通过默认网关时就可以配置网络路由。

        实际工作中会有需求，两个不同的内部网络互访
        [root@tomcat ~]# route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1
        SIOCADDRT: Network is unreachable                         #当连不通地址192.168.1.1时，无法添加路由
        [root@tomcat ~]# ifconfig eth0:0 192.168.1.1/24 up        #添加别名IP临时测试，如果需要永久生效最好加双网卡或写入到配置文件
        [root@tomcat ~]# ifconfig eth0:0            #查看添加的IP别名（网络里把这种多IP的方式称为子接口）
        eth0:0    Link encap:Ethernet  HWaddr 00:0C:29:9F:D7:6D
                inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
                UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
        添加去192.168.1.0的数据包，交给192.168.1.1处理

        route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1
        route add -net 192.168.1.0 netmask 255.255.255.0 dev eth0         ## 指定设备名，这种写法也可以
        route add -net 192.168.1.0/24 dev eth0
        route del -net 192.168.1.0/24 dev eth0

    主机路由
        去往某个主机地址的路由
            route add -host 192.168.2.13 dev eth2
            route add -host 202.81.11.91 dev lo
        例如：keepalived或heartbeat高可用服务器对之间的使用单独网卡接心跳线通信就会用到以上主机路由。

实例
----

.. code:: bash

    route命令
        添加路由
            route add -net 192.168.0.0/24 gw 192.168.0.1
            route add -host 192.168.1.1 dev 192.168.0.1

        删除路由
            route del -net 192.168.0.0/24 gw 192.168.0.1

            add 增加路由
            del 删除路由
            -net 设置到某个网段的路由
            -host 设置到某台主机的路由
            gw 出口网关 IP地址
            dev 出口网关 物理设备名

        增加默认路由
            route add default gw 192.168.0.1
        route add default gw 192.168.0.1 就相当于route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.168.0.1

        删除默认路由
            route del default gw 192.168.0.1
        删除一条静态路由：
            route del -net 192.168.1.0/24
            或route del -net 192.168.1.0 netmask 255.225.255.0
        删除一条主机路由：
            route del -host 192.168.1.10 dev eth0

        查看路由表
            route -n
            netstat -rn

    ip命令
        添加路由
        ip route add 192.168.0.0/24 via 192.168.0.1
        ip route add 192.168.1.1 dev 192.168.0.1
        删除路由
        ip route del 192.168.0.0/24 via 192.168.0.1

        via 网关出口 IP地址
        dev 网关出口 物理设备名

        增加默认路由
        ip route add default via 192.168.0.1 dev eth0
        via 192.168.0.1 是我的默认路由器

        查看路由信息
        ip route

保存路由设置，使其在网络重启后任然有效
--------------------------------------

.. code:: bash

    一：
        在/etc/sysconfig/network-script/目录下创建名为route-eth0的文件
        vi /etc/sysconfig/network-script/route-eth0
        在此文件添加如下格式的内容
        192.168.1.0/24 via 192.168.0.1


    二：
        /etc/rc.d/init.d/network中有这么几行：
        # Add non interface-specific static-routes.
        if [ -f /etc/sysconfig/static-routes ]; then
        grep "^any" /etc/sysconfig/static-routes | while read ignore args ; do
        /sbin/route add -$args
        done
        fi
        也就是说，将静态路由加到/etc/sysconfig/static-routes 文件中就行了。
        如加入：
        route add -net 192.168.0.1 netmask 255.255.255.0 gw 192.168.1.1

        则static-routes的格式为
        any net 192.168.0.1 netmask 255.255.255.0 gw 192.168.1.1
    三：
        vi /etc/rc.local
        加入如下内容：
        route add -net 192.168.1.0/24 gw 192.168.1.1
        PS: 方法一推荐生产环境使用
        提示：此方法写到/etc/rc.local里只在开机时加载，当手工重启网络后会失效，但是重启系统后会生效！

    默认路由可在网卡配置里面指定：
        /etc/sysconfig/network-scripts/ifcfg-eth0
        GATEWAY=192.168.0.1

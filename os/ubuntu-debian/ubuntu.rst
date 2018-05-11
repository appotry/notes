Ubuntu
======

查看系统信息
------------

1. ``cat /etc/issue``
2. ``cat /proc/version``
3. ``uname -a``
4. ``lsb_release -a``
5. ``cat /etc/lsb-release``

Ubuntu网络
----------

ubuntu 网卡配置文件
~~~~~~~~~~~~~~~~~~~

::

    root@ubuntu:~# vim /etc/network/interfaces

重启网卡
~~~~~~~~

::

    root@ubuntu:~# /etc/init.d/networking restart

获取IP
~~~~~~

::

    dhclient eth1

APT
---

配置文件路径
~~~~~~~~~~~~

::

    /etc/apt/

apt源配置
~~~~~~~~~

.. code:: shell

    root@ubuntu191:/etc/apt/sources.list.d# cat zabbix.list
    #deb     http://repo.zabbix.com/zabbix/3.0/ubuntu xenial main
    #deb-src http://repo.zabbix.com/zabbix/3.0/ubuntu xenial main

    deb      http://mirrors.aliyun.com/zabbix/zabbix/3.0/ubuntu   xenial  main
    deb-src  http://mirrors.aliyun.com/zabbix/zabbix/3.0/ubuntu   xenial  main

16.04
^^^^^

网易源
''''''

.. code:: shell

    deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse

apt-get
~~~~~~~

常用参数

.. code:: shell

    apt-cache search package 搜索软件包
    apt-cache show package  获取包的相关信息，如说明、大小、版本等
    apt-get install package 安装包
    apt-get install package --reinstall   重新安装包
    apt-get -f install   修复安装
    apt-get remove package 删除包
    apt-get remove package --purge 删除包，包括配置文件等
    apt-get update  更新源
    apt-get upgrade 更新已安装的包
    apt-get dist-upgrade 升级系统
    apt-cache depends package 了解使用该包依赖那些包
    apt-cache rdepends package 查看该包被哪些包依赖
    apt-get build-dep package 安装相关的编译环境
    apt-get source package  下载该包的源代码
    pt-get clean && sudo apt-get autoclean 清理无用的包
    apt-get check 检查是否有损坏的依赖

搜索apt源里面的包
~~~~~~~~~~~~~~~~~

::

    apt-cache search zabbix

软件
----

软件安装
~~~~~~~~

::

    dpkg -i
    apt-get

查看软件信息
~~~~~~~~~~~~

查看已安装软件

.. code:: shell

    root@ubuntu75:~# dpkg -l

    在终端下也可以很方便查看已安装的软件包版本号，也能单独查看所需要的软件包是否已安装和版本号，还能查看可升级的软件包。在终端下要实现这个目标就要用到一个软件工具叫做apt-show-versions，通过apt-get安装：
    apt-get install apt-show-versions

    apt-show-versions
        查看所有已安装的软件包和版本号，可以使用more来显示每屏的内容，或者使用grep抓取等等
    apt-show-versions |more
        按回车键打印下一行，按下空格键打印下一屏，按下Q键退出打印结果。如果想查看单个软件包的版本，则使用命令：
    apt-show-versions –p //是软件包名，不含符号
        如果想查看可升级的软件包，则使用命令：
    apt-show-versions –u
        如果没有任何可以升级的软件包，上面那条命令不会返回任何结果的。更多的参数查看man，这两个方法哪个好用仁者见仁了。

查看软件安装目录以及安装版本
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1.查询版本

-  ``aptitude show 软件名``

   -  例如：aptitude show kde-runtime

-  ``dpkg -l 软件名``

   -  例如：dpkg -l gedit

2.查询安装路径

-  ``dpkg -L 软件名``

   -  例如：dpkg -L gedit

-  ``whereis 软件名``

   -  例如：whereis gedit

问题记录
--------

系统重启后resolv.conf被清空
~~~~~~~~~~~~~~~~~~~~~~~~~~~

自定义\ ``nameserver``, 具体相关信息运行命令\ ``man resolvconf``

1. 在网卡的配置文件里面加

.. code:: shell

    iface eth0 inet static
    address 192.168.3.3
    netmask 255.255.255.0
    gateway 192.168.3.1
    dns-nameservers 192.168.3.45 192.168.8.10
    dns-search foo.org bar.com

2. 修改 ``resolvconf`` 服务的配置文件:
   ``/etc/resolvconf/resolv.conf.d/base``

.. code:: shell

    root@ubuntu:~# cat /etc/resolvconf/resolv.conf.d/base
    nameserver 223.5.5.5 114.114.114.114

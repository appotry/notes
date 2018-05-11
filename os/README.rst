os
==

Linux kernel map
----------------

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux-kernel-map.jpg
   :alt: Linux-kernel-map

   Linux-kernel-map

系统信息
--------

mac
~~~

.. code:: shell

    system_profiler命令：显示Mac的硬件和软件信息
    sw_vers命令：OSX系统版本
    uname命令：显示操作系统名

Linux
~~~~~

查看内核版本

.. code:: shell

    uname -a

    cat /proc/version

查看Linux版本

.. code:: shell

    lsb_release -a

    /etc/issue
    /etc/system-release
    /etc/redhat-release

    /etc/centos-release

    # ubuntu
    /etc/os-release

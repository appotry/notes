Linux挂载NTFS分区
=================

安装ntfs-3g
-----------

.. code:: shell

        sudo apt-get install ntfs-3g  # Ubuntu
        sudo yum install ntfs-3g      # CentOS

fdisk -l查看磁盘设备点,挂载设备
-------------------------------

::

    mount -t ntfs-3g /dev/sdb1 /ntfs

开机自动挂载
------------

vi /etc/fstab文件里面添加需要挂载的NTFS盘

内容如下:

::

    /dev/sdb1 /ntfs ntfs-3g defaults 0 0

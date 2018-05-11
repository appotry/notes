MySQL
=====

`www.90root.com <http://www.90root.com/category/DB/>`__
`www.abcdocker.com <http://www.abcdocker.com/abcdocker/category/mysql>`__

MySQL 5.7 yum安装
-----------------

.. code:: shell

    [root@ruin ~]# cat /etc/redhat-release
    CentOS release 6.6 (Final)
    [root@ruin ~]# uname -a
    Linux ruin 2.6.32-504.el6.x86_64 #1 SMP Wed Oct 15 04:27:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
    [root@ruin ~]# ifconfig|sed -n '2p'|awk -F'[ :]+' '{print $4}'
    10.0.11.103

    [root@ruin ~]# rpm -ivh http://repo.mysql.com//mysql57-community-release-el6-9.noarch.rpm
    [root@ruin ~]# ll /etc/yum.repos.d/
    总用量 16
    -rw-r--r-- 1 root root 1991 10月 23 2014 CentOS-Base.repo
    -rw-r--r-- 1 root root 1083 5月  15 2015 epel.repo
    -rw-r--r-- 1 root root 1414 9月  12 18:32 mysql-community.repo
    -rw-r--r-- 1 root root 1440 9月  12 18:32 mysql-community-source.repo

    [root@ruin ~]# yum repolist enabled | grep "mysql.*-community.*"
    mysql-connectors-community MySQL Connectors Community                         30
    mysql-tools-community      MySQL Tools Community                              42
    mysql57-community          MySQL 5.7 Community Server                        162
    [root@ruin ~]# yum install mysql-community-server -y
    [root@ruin ~]# /etc/init.d/mysqld start
    [root@ruin ~]# netstat -lntp|grep mysql
    tcp        0      0 :::3306                     :::*                        LISTEN      4493/mysqld
    [root@ruin ~]# grep 'temporary password' /var/log/mysqld.log
    2017-01-06T07:07:07.718302Z 1 [Note] A temporary password is generated for root@localhost: hr6Oe8_o-EA(

    [root@ruin ~]# mysql -uroot -phr6Oe8_o-EA\(
    mysql>

`MySQL
5.7官网手册 <http://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html>`__

MySQL设置root密码
-----------------

SQL命令行set 修改
~~~~~~~~~~~~~~~~~

.. code:: bash

    [root@ruin ~]# mysql -uroot -phr6Oe8_o-EA\(
    mysql> use mysql
    ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.
    #需要设置密码，详见下面参考连接
    mysql> set password=password('12345');
    ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
    #增加了密码强度验证，详见下面参考连接
    mysql> set password=password('Lr1993*0614_');
    mysql> flush privileges;

shell 命令行mysqladmin修改
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #当没有密码时设置新密码为123456
    [root@ruin ~]# mysqladmin -u root password 123456

    #当存在密码时
    [root@ruin ~]# mysqladmin -uroot -pLr2017*0614_ password Lr2017*0000__
    [root@ruin ~]# mysql -uroot -pLr2017*0614_
    mysql: [Warning] Using a password on the command line interface can be insecure.
    ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
    [root@ruin ~]# mysql -uroot -pLr2017*0000__
    mysql>

SQL命令行update语句修改
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    [root@ruin ~]# mysql -uroot -pLr2017*0000__
    mysql> use mysql;
    mysql> update user set password=password('Lr2017*0614_') where user='root';
    ERROR 1054 (42S22): Unknown column 'password' in 'field list'
    #没有该字段，详见下面参考连接
    mysql> update mysql.user set authentication_string=password('Lr2017*0614_') where user='root';
    mysql> flush privileges;

`ERROR 1820 (HY000) <http://www.cnblogs.com/t1508001/p/5821452.html>`__

`ERROR 1819
(HY000) <http://blog.csdn.net/zyz511919766/article/details/12752741>`__

`ERROR 1054
(42S22) <http://blog.csdn.net/u010603691/article/details/50379282>`__

`官方文档 <http://dev.mysql.com/doc/refman/5.7/en/validate-password-plugin.html>`__

忘记密码时,登录修改
~~~~~~~~~~~~~~~~~~~

`Linux环境下mysql的root密码忘记解决方法 <http://lxsym.blog.51cto.com/1364623/477027/>`__

修改my.cnf重启进程跳过授权表改密码
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: shell

    [root@ruin ~]# vi /etc/my.cnf
    [root@ruin ~]# grep -A1 '\[mysqld\]' /etc/my.cnf
    [mysqld]
    skip-grant-tables

    [root@ruin ~]# /etc/init.d/mysqld restart
    停止 mysqld：                                              [确定]
    正在启动 mysqld：                                          [确定]
    [root@ruin ~]# mysql
    mysql> update mysql.user set authentication_string=password('Lr2017*0610_') where user='root';
    mysql> flush privileges;

    [root@ruin ~]# vi /etc/my.cnf #删除skip-grant-tables
    [root@ruin ~]# /etc/init.d/mysqld restart
    [root@ruin ~]# mysql -uroot -pLr2017*0610_
    mysql>

使用mysqld_safe跳过授权表改密码
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: bash

    [root@ruin ~]# netstat -lntp|grep mysql
    tcp        0      0 :::3306                     :::*                        LISTEN      5699/mysqld
    [root@ruin ~]# killall -TERM mysqld
    [root@ruin ~]# netstat -lntp|grep mysql
    [root@ruin ~]# mysqld_safe --skip-grant-tables &
    [1] 5751
    [root@ruin ~]# mysql
    mysql> update mysql.user set authentication_string=password('Lr2017*0614_') where user='root';
    mysql> flush privileges;
    [root@ruin ~]# killall -TERM mysqld
    [root@ruin ~]# /etc/init.d/mysqld start
    [root@ruin ~]# mysql -uroot -pLr2017*0614_
    mysql>

MySQL授权访问
-------------

.. code:: bash

    #5.7版本默认localhost连接
    [root@ruin ~]# mysql -h10.0.11.103 -uroot -pLr2017*0614_
    mysql: [Warning] Using a password on the command line interface can be insecure.
    ERROR 1130 (HY000): Host '10.0.11.103' is not allowed to connect to this MySQL server

    [root@ruin ~]# mysql -uroot -pLr2017*0614_
    mysql> select host,user from mysql.user;
    +-----------+-----------+
    | host      | user      |
    +-----------+-----------+
    | localhost | mysql.sys |
    | localhost | root      |
    +-----------+-----------+
    2 rows in set (0.00 sec)

grant 命令用于授权，详情查看help

直接对用户授权
~~~~~~~~~~~~~~

.. code:: bash

    mysql> help grant;
    #简单来说就是grant 权限 on 数据库.表 to 用户@主机 identified by '密码' with grant option

    mysql> grant all privileges on *.* to root@'10.0.11.%' identified by 'Lr2017*0614_' with grant option;
    Query OK, 0 rows affected, 1 warning (0.00 sec)

    mysql> show grants for root@'10.0.11.%';
    +---------------------------------------------------------------------+
    | Grants for root@10.0.11.%                                           |
    +---------------------------------------------------------------------+
    | GRANT ALL PRIVILEGES ON *.* TO 'root'@'10.0.11.%' WITH GRANT OPTION |
    +---------------------------------------------------------------------+
    1 row in set (0.00 sec)

    mysql> show grants for root@'10.0.11.%';
    +---------------------------------------------------------------------+
    | Grants for root@10.0.11.%                                           |
    +---------------------------------------------------------------------+
    | GRANT ALL PRIVILEGES ON *.* TO 'root'@'10.0.11.%' WITH GRANT OPTION |
    +---------------------------------------------------------------------+
    1 row in set (0.00 sec)

    mysql> select host,user from mysql.user;
    +-----------+-----------+
    | host      | user      |
    +-----------+-----------+
    | 10.0.11.% | root      |
    | localhost | mysql.sys |
    | localhost | root      |
    +-----------+-----------+
    3 rows in set (0.00 sec)

    mysql> quit
    Bye
    [root@ruin ~]# mysql -h10.0.11.103 -uroot -pLr2017*0614_
    mysql>

先创建用户在授权
~~~~~~~~~~~~~~~~

.. code:: bash

    mysql> create user test@10.0.11.103 identified by 'Test*123_';
    mysql> grant select,update,delete,insert on *.* to test@10.0.11.103;
    mysql> flush privileges;
    mysql> show grants for test@'10.0.11.103';
    +---------------------------------------------------------------------+
    | Grants for test@10.0.11.103                                         |
    +---------------------------------------------------------------------+
    | GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'test'@'10.0.11.103' |
    +---------------------------------------------------------------------+
    1 row in set (0.00 sec)

    mysql> select host,user from mysql.user;
    +-------------+-----------+
    | host        | user      |
    +-------------+-----------+
    | 10.0.11.%   | root      |
    | 10.0.11.103 | test      |
    | localhost   | mysql.sys |
    | localhost   | root      |
    +-------------+-----------+
    4 rows in set (0.00 sec)

创建库，表，用户
----------------

创建库
~~~~~~

`创建库官方文档 <http://dev.mysql.com/doc/refman/5.7/en/create-database.html>`__

.. code:: bash

    #查看创库帮助文档
    mysql> help create database;

    #创建utf8字符集和collate校对字符集为utf8_general_ci的库
    mysql> create database liurui default charset utf8 collate utf8_general_ci;

    #查看数据库支持的字符集和collate校对字符集
    mysql> show character set;

    #查看库
    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | liurui             |
    | mysql              |
    | performance_schema |
    | sys                |
    +--------------------+
    5 rows in set (0.00 sec)

    #查看创库语句
    mysql> show create database liurui;
    +----------+-----------------------------------------------------------------+
    | Database | Create Database                                                 |
    +----------+-----------------------------------------------------------------+
    | liurui   | CREATE DATABASE `liurui` /*!40100 DEFAULT CHARACTER SET utf8 */ |
    +----------+-----------------------------------------------------------------+
    1 row in set (0.00 sec)

创建表
~~~~~~

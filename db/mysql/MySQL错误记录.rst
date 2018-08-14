MySQL错误记录
=============

MySQL常见错误代码及代码说明
---------------------------

.. code:: shell

    1005：创建表失败
    1006：创建数据库失败
    1007：数据库已存在，创建数据库失败<=================可以忽略
    1008：数据库不存在，删除数据库失败<=================可以忽略
    1009：不能删除数据库文件导致删除数据库失败
    1010：不能删除数据目录导致删除数据库失败
    1011：删除数据库文件失败
    1012：不能读取系统表中的记录
    1020：记录已被其他用户修改
    1021：硬盘剩余空间不足，请加大硬盘可用空间
    1022：关键字重复，更改记录失败
    1023：关闭时发生错误
    1024：读文件错误
    1025：更改名字时发生错误
    1026：写文件错误
    1032：记录不存在<=============================可以忽略
    1036：数据表是只读的，不能对它进行修改
    1037：系统内存不足，请重启数据库或重启服务器
    1038：用于排序的内存不足，请增大排序缓冲区
    1040：已到达数据库的最大连接数，请加大数据库可用连接数
    1041：系统内存不足
    1042：无效的主机名
    1043：无效连接
    1044：当前用户没有访问数据库的权限
    1045：不能连接数据库，用户名或密码错误
    1048：字段不能为空
    1049：数据库不存在
    1050：数据表已存在
    1051：数据表不存在
    1054：字段不存在
    1062：字段值重复，入库失败<==========================可以忽略
    1065：无效的SQL语句，SQL语句为空
    1081：不能建立Socket连接
    1114：数据表已满，不能容纳任何记录
    1116：打开的数据表太多
    1129：数据库出现异常，请重启数据库
    1130：连接数据库失败，没有连接数据库的权限
    1133：数据库用户不存在
    1141：当前用户无权访问数据库
    1142：当前用户无权访问数据表
    1143：当前用户无权访问数据表中的字段
    1146：数据表不存在
    1147：未定义用户对数据表的访问权限
    1149：SQL语句语法错误
    1158：网络错误，出现读错误，请检查网络连接状况
    1159：网络错误，读超时，请检查网络连接状况
    1160：网络错误，出现写错误，请检查网络连接状况
    1161：网络错误，写超时，请检查网络连接状况
    1169：字段值重复，更新记录失败
    1177：打开数据表失败
    1180：提交事务失败
    1181：回滚事务失败
    1203：当前用户和数据库建立的连接已到达数据库的最大连接数，请增大可用的数据库连接数或重启数据库
    1205：加锁超时
    1211：当前用户没有创建用户的权限
    1216：外键约束检查失败，更新子表记录失败
    1217：外键约束检查失败，删除或修改主表记录失败
    1226：当前用户使用的资源已超过所允许的资源，请重启数据库或重启服务器
    1227：权限不足，您无权进行此操作
    1235：MySQL版本过低，不具有本功能

MySQL初始化故障排错集锦
-----------------------

错误示例1：warning：The host ‘mysql’ could not be looked up with resolve ip
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

需修改主机名的解析，使其和uname -n一样

错误示例2：error：1004 can’t create file ‘/tmp/#sql300e_1_0.frm’(errno: 13)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

错误示例2下面也是初始化数据库时可能会遇到的错误，原因是/tmp目录的权限问题：

解决办法

查看/tmp目录权限

修改权限 chmod -R 1777 /tmp/

sql语句错误, 导致slave sql线程出错, 主从不一致
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

可以手动告诉从库slave_sql线程让他忽略掉这个错误继续执行

.. code:: sql

    mysql>set global sql_slave_skip_counter=1;
    mysql>start slave;

或者运行 ``SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;`` 跳过一行错误

主库可以配置某些语句不记录到binlog

InnoDB is limited to row-logging when transaction
isolation level is READ COMMITTED or READ UNCOMMITTED
-------------------------------------------------------------------------------------------------------

执行语句的时候报如下错误

.. code:: shell

    ERROR 1665 (HY000): Cannot execute statement: impossible to write to binary log since BINLOG_FORMAT = STATEMENT and at least one table uses a storage engine limited to row-based logging. InnoDB is limited to row-logging when transaction isolation level is READ COMMITTED or READ UNCOMMITTED.
    mysql> quit
    Bye

原因是\ ``transaction_isolation``\ 使用的\ ``READ-COMMITTED``

innodb的事务隔离级别是\ ``READ COMMITTED``\ 或者\ ``READ UNCOMMITTED``\ 模式时，
\ ``BINLOG_FORMAT``\ 不可以使用\ ``STATEMENT``\ 模式

``binlog_format``\ 使用\ ``mixed``

::

    set global binlog_format=mixed

重新建立的会话session中binlog format会变为mixed模式。

或者修改innodb事务隔离级别

使用spring连接mysql的时候, 提示依赖使用SSL连接
----------------------------------------------

具体报错

WARN: Establishing SSL connection without server’s identity verification
is not recommended. According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+
requirements SSL connection must be established by default if explicit
option isn’t set. For compliance with existing applications not using
SSL the verifyServerCertificate property is set to ‘false’. You need
either to explicitly disable SSL by setting useSSL=false, or set
useSSL=true and provide truststore for server certificate verification.

可以关闭SSl认证, 或者提供证书

``application.properties``\ 文件修改,
添加参数\ ``?verifyServerCertificate=false&useSSL=false&requireSSL=false``

.. code:: shell

    spring.datasource.url=jdbc:mysql://localhost:3306/db_example?verifyServerCertificate=false&useSSL=false&requireSSL=false

解决mysql使用GTID主从复制错误问题
-----------------------------------------------

主从网络中断,或主服务器重启,或从服务器重启,从会根据配置文件中的时间,默认1分钟,去自动重连主服务器,直到网络和服务均可正常连接,连接正常后可自动继续同步之前文件,不需要任何人工干预.

当主从因为人为原因出现不同步的时候,可以用下面命令进行同步::

    LOAD DATA FROM MASTER;
    LOAD TABLE TBLNAME FROM MASTER;

注意,上面命令会对主数据库进行锁操作,如果数据库极大,建议在停机的时候进行,或者用短锁备份查看 show master status; 后,拷贝数据库的方式进行.

当 BIN-LOG 里面出现 SQL 级别错误导致主从不能同步的时候,可以用下面方法掠过该错误语句行,继续同步::

    stop slave;
    set global sql_slave_skip_counter=1;
    start slave;

执行当 ``set global sql_slave_skip_counter=1;`` 是可能会出现以下错误::

    ERROR 1858 (HY000): sql_slave_skip_counter can not be set when the server is running with GTID_MODE = ON. 
    Instead, for each transaction that you want to skip, generate an empty transaction with the same GTID as the transaction

解决::

    show slave status\G
    # 记录 Executed_Gtid_Set

    reset master;
    stop slave;
    reset slave;
    # 使用上面的 Executed_Gtid_Set + 1，根据具体情况调整
    set global gtid_purged='2a378de7-bf79-11e7-b8c1-7cd30ac474ca:1-7899,47f27a52-bf79-11e7-b8c2-7cd30ae01298:1-153820893';
    CHANGE MASTER TO MASTER_HOST='host', MASTER_PORT=3306, MASTER_USER='user', MASTER_PASSWORD='password', MASTER_AUTO_POSITION=1, MASTER_DELAY = 3600;
    START SLAVE;

    show slave status\G

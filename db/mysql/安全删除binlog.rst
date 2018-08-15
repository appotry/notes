安全删除binlog日志
==================

有三种解决方法：

1. 关闭mysql主从，关闭binlog
2. 开启mysql主从，设置expire_logs_days
3. 手动清除binlog文件

重启mysql,开启mysql主从，设置expire_logs_days
---------------------------------------------

.. code:: shell

    # vim /etc/my.cnf  //修改expire_logs_days,x是自动删除的天数，一般将x设置为短点，如10
    expire_logs_days = x  //二进制日志自动删除的天数。默认值为0,表示“没有自动删除”
    三种情况下会做 flush logs 操作
    1. 重启
    2. BINLOG文件大小达到参数max_binlog_size限制，max_binlog_size默认为1G
    3. 手工执行命令。

    此方法需要重启mysql，附录有关于expire_logs_days的英文说明

    当然也可以不重启mysql,开启mysql主从，直接在mysql里设置expire_logs_days,临时
    mysql> show binary logs;
    +------------------+-----------+
    | Log_name         | File_size |
    +------------------+-----------+
    | mysql-bin.000678 |    558332 |
    +------------------+-----------+
    1 row in set (0.00 sec)

    mysql> show variables like '%log%';
    mysql> set global expire_logs_days = 10;
    mysql> show variables like '%expire_logs_days%';
    +------------------+-------+
    | Variable_name    | Value |
    +------------------+-------+
    | expire_logs_days | 10    |
    +------------------+-------+
    1 row in set (0.02 sec)

手动清除binlog文件
------------------

.. code:: bash

    mysql> PURGE MASTER LOGS BEFORE DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY);   //删除10天前的MySQL binlog日志,附录2有关于PURGE MASTER LOGS手动删除用法及示例

    mysql> show master logs;
    +------------------+-----------+
    | Log_name         | File_size |
    +------------------+-----------+
    | mysql-bin.000678 |    558332 |
    +------------------+-----------+
    1 row in set (0.02 sec)


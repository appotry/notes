innobackupex
=====================

1.XtraBackup 有两个工具：xtrabackup 和 innobackupex：

* xtrabackup 本身只能备份 InnoDB 和 XtraDB ，不能备份 MyISAM；
* innobackupex 本身是 Hot Backup 脚本修改而来，同时可以备份 MyISAM 和 InnoDB，但是备份 MyISAM 需要加读锁。

2.一般情况下，在备份完成后，数据尚且不能用于恢复操作，因为备份的数据中可能会包含尚未提交的事务或已经提交但尚未同步至数据文件中的事务。因此，此时数据文件仍处理不一致状态。“准备”的主要作用正是通过回滚未提交的事务及同步已经提交的事务至数据文件也使得数据文件处于一致性状态。

    innobackupex --apply-log  /backup-path

3.在实现“准备”的过程中，innobackupex 通常还可以使用 ``--use-memory`` 选项来指定其可以使用的内存的大小，默认通常为 100M。如果有足够的内存可用，可以多划分一些内存给 prepare 的过程，以提高其完成速度。

4.用 innobackupex 备份数据时，–apply-log 处理过的备份数据里有两个文件说明该备份数据对应的 binlog 的文件名和位置。但有时这俩文件说明的位置可能会不同::

    对于纯 InnoDB 操作，备份出来的数据中上述两个文件的内容是一致的。
    对于 InnoDB 和非事务存储引擎混合操作，xtrabackup_binlog_info 中所示的 position 应该会比 xtrabackup_pos_innodb 所示的数值大。此时应以 xtrabackup_binlog_info 为准；而后者和 apply-log 时 InnoDB recovery log 中显示的内容是一致的，只针对 InnoDB 这部分数据

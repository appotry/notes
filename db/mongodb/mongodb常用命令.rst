mongodb常用命令
===============

登录数据库：
------------

.. code:: shell

    mongo 192.168.2.199:27017/admin (库名)
    mongo 192.168.2.199:27017/admin -u system -p BJjg10661898

查看帮助
--------

.. code:: shell

    db.help()                显示数据库操作命令
    db.foo.help()            显示集合（表）操作命令，foo指的是当前数据库下，一个叫foo的集合

查看数据库
----------

.. code:: shell

    show dbs

使用数据库
----------

.. code:: shell

    use admin

查看集合(表)
------------

.. code:: shell

    show collections （show tables）

添加系统管理员账号,用于管理用户
-------------------------------

.. code:: shell

    db.createUser({user:"system",pwd:"*****",roles:[{role:"root",db:"admin"}]})

验证

.. code:: shell

    db.auth("system", "BJjg10661898");

添加数据库管理员,用来管当前数据库
---------------------------------

.. code:: shell

    db.createUser({user:"lottery",pwd:"0okmnhy6",roles:["dbOwner"]})

查找用户
--------

.. code:: shell

    db.system.users.find();

创建数据库
----------

.. code:: shell

    use alidayusms

创建了一个数据库,如果什么都不操作离开的话,库就会被系统删除.所以要创建一个集合（表）

.. code:: shell

    db.test.insert({'name':'test'});

删除当前使用数据库：
--------------------

.. code:: shell

    use test
    db.dropDatabase();

创建集合(表)
------------

.. code:: shell

    use alidayusms
    db.test.insert({'name':'test'});

删除集合(表)
------------

.. code:: shell

    db.test.drop()

导出库
------

导入库
------

导出集合(表)
------------

.. code:: shell

    mongoexport -d alidayusms -c systemConfig -o /tmp/systemConfig.dat

导入集合(表)
------------

.. code:: shell

    mongoimport -h 192.168.2.199 --port 27017 -u lottery -p 0okmnhy6 -d alidayusms -c systemConfig --upsert --drop /opt/systemConfig.dat

    -h              指定主机，可用主机名或者IP
    --port          指定端口
    -u              指定用户
    -p              指定密码
    -d              指定库
    -c              指定集合（表）
    --upsert        插入或者更新现有数据

创建只读用户
------------

.. code:: shell

    db.createUser({user: "zhangguoqing",pwd: "zhangguoqing",roles: [{ role: "read", db: "genlotogw" }]})
    Successfully added user: {
        "user" : "zhanggguoqing",
        "roles" : [
            {
                "role" : "read",
                "db" : "genlotogw"
            }
        ]
    }

    db.createUser({user: "zhanggguoqing",pwd: "zhangguoqing",roles: ["read"]})

`mongodb用户相关 <http://www.cnblogs.com/zhoujinyi/p/4610050.html>`__

监控
----

.. code:: shell

    mongostat -h 192.168.2.199 -u system -p BJjg10661898 --authenticationDatabase=admin

慢查询分析：
------------

.. code:: shell

    db.setProfilingLevel()

https://docs.mongodb.com/manual/reference/method/db.setProfilingLevel/

https://docs.mongodb.com/v3.0/tutorial/manage-the-database-profiler/

.. code:: shell

    lottery:PRIMARY> db.getProfilingStatus()
    { "was" : 1, "slowms" : 100 }

    lottery:PRIMARY> db.getProfilingLevel()
    0

    db.setProfilingLevel()

    db.system.profile.find().limit(10).sort( { ts : -1 } ).pretty()

找出对我们有用的数据
--------------------

.. code:: shell

    show dbs
    use ticketcenter
    > db.getProfilingStatus()                  #默认的100
    > { "was" : 0, "slowms" : 100 }

    > db.setProfilingLevel(1,200)              #设置200
    > { "was" : 0, "slowms" : 100, "ok" : 1 }

    > db.getProfilingStatus()
    > { "was" : 1, "slowms" : 200 }

    db.system.profile.find().limit(10).sort( { ts : -1 } ).pretty()

    db.setProfilingLevel()

    db.getProfilingStatus()

查看索引
--------

.. code:: shell

    use tiecketcenter
    db.ticket.getIndexes()

后台建立索引
------------

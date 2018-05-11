mongodb快速入门
===============

安装
----

`mongodb
install <https://docs.mongodb.com/master/administration/install-community/>`__

.. code:: shell

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

    echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list

    sudo apt-get update

    sudo apt-get install -y mongodb-org

    sudo service mongod start

mongo shell
-----------

.. code:: shell

    root@ubuntu66:~# mongo
    MongoDB shell version v3.4.2
    connecting to: mongodb://127.0.0.1:27017
    MongoDB server version: 3.4.2
    Welcome to the MongoDB shell.
    For interactive help, type "help".
    For more comprehensive documentation, see
        http://docs.mongodb.org/
    Questions? Try the support group
        http://groups.google.com/group/mongodb-user
    Server has startup warnings:
    2017-03-06T21:35:50.232+0800 I STORAGE  [initandlisten]

    ...

创建数据库
~~~~~~~~~~

::

    use DATABASE_NAME

用于创建数据库,数据库不存在,创建,存在,切换到现有数据库

查看当前所在数据库,使用db

::

    > db
    test

创建数据库

::

    > use mydb
    switched to db mydb
    > db
    mydb

查看数据库列表,使用dbs

::

    > show dbs
    admin  0.000GB
    local  0.000GB

创建的数据库(mydb)不存在列表中,要显示数据库,需要至少插入一个文档.

::

    > db.movie.insert({"x":1})
    WriteResult({ "nInserted" : 1 })
    > show dbs
    admin  0.000GB
    local  0.000GB
    mydb   0.000GB

MongoDB的默认数据库是test。
如果没有创建任何数据库，那么集合将被保存在测试数据库。

删除数据库
~~~~~~~~~~

::

    > db
    mydb
    > db.dropDatabase()
    { "dropped" : "mydb", "ok" : 1 }
    > show dbs
    admin  0.000GB
    local  0.000GB

创建集合
~~~~~~~~

::

    db.createCollection(name,options)

+---------+----------+----------------------------------+
| 参数    | 类型     | 描述                             |
+=========+==========+==================================+
| name    | String   | 要创建的集合的名称               |
+---------+----------+----------------------------------+
| options | Document | (可选)指定有关内存大小和索引选项 |
+---------+----------+----------------------------------+

::

    > use test
    switched to db test
    > db.createCollection("mycollection")
    { "ok" : 1 }

查看集合

::

    > show collections
    mycollection

选项列表

+-----------------------+-----------------------+-----------------------+
| 字段                  | 类型                  | 描述                  |
+=======================+=======================+=======================+
| capped                | Boolean               | (可选)如果为true,它启用上限集合.上 |
|                       |                       | 限集合是一个固定大小的集合,当它达到其最大 |
|                       |                       | 尺寸会自动覆盖最老的条目,如果指定true |
|                       |                       | ,则还需要指定参数的大小. |
+-----------------------+-----------------------+-----------------------+
| autoIndexID           | Boolean               | (可选)如果为true,自动创建索引_id |
|                       |                       | 字段.默认的值是False  |
+-----------------------+-----------------------+-----------------------+
| size                  | number                | (可选)指定的上限集合字节的最大尺寸.如果 |
|                       |                       | capped是true,那么还需要指定这个 |
|                       |                       | 字段.                 |
+-----------------------+-----------------------+-----------------------+
| max                   | number                | (可选)指定上限集合允许的最大文件数. |
+-----------------------+-----------------------+-----------------------+

.. code:: shell

        > db.createCollection("mycol", { capped : true, autoIndexId:true, size : 6142800, max : 10000 } )
        {
            "note" : "the autoIndexId option is deprecated and will be removed in a future release",
            "ok" : 1
        }
        > show collections
        mycol
        mycollection

删除集合
~~~~~~~~

.. code:: shell

        db.COLLECTION_NAME.drop()

        > db.mycollection.drop()
        true

插入文档
~~~~~~~~

将数据插入到Mongodb集合

::

    db.COLLECTION_NAME.insert(document)

    > db.mycol.insert({
    ... title: 'MongoDB Overview',
    ... description: 'MongoDB is no sql database',
    ... likes: 100
    ... })
    WriteResult({ "nInserted" : 1 })

这里 mycol
是我们的集合名称，它是在之前的教程中创建。如果集合不存在于数据库中，那么MongoDB创建此集合，然后插入文档进去。

在如果我们不指定_id参数插入的文档，那么 MongoDB
将为文档分配一个唯一的ObjectId。

要以单个查询插入多个文档,可以通过文档insert()命令的数组方式

查询文档
~~~~~~~~

要从集合查询Mongodb数据,需要使用find()方法

.. code:: shell

    db.COLLECTION_NAME.find()

find() 方法将在非结构化的方式显示所有的文件。
如果显示结果是格式化的，那么可以用pretty() 方法。

.. code:: shell

        > db.mycol.find()
        { "_id" : ObjectId("58be1aaaf84bcc15e691533b"), "title" : "MongoDB Overview", "description" : "MongoDB is no sql database", "likes" : 100 }
        > db.mycol.find().pretty()
        {
            "_id" : ObjectId("58be1aaaf84bcc15e691533b"),
            "title" : "MongoDB Overview",
            "description" : "MongoDB is no sql database",
            "likes" : 100
        }
        >

除了find()方法,还有findOne()方法,仅返回一个文档

RDBMS Where子句等效于MongoDB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

查询文档在一些条件的基础上，可以使用下面的操作

.. code:: shell

    操作: Equality
        语法: {<key>:<value>}
        示例: db.mycol.find({"by":"yiibai tutorials"}).pretty()
        RDBMS等效语句: where by = 'yiibai tutorials'

    Less Than
        {<key>:{$lt:<value>}}
        db.mycol.find({"likes":{$lt:50}}).pretty()
        where likes < 50

    Less Than Equals
        {<key>:{$lte:<value>}}
        db.mycol.find({"likes":{$lte:50}}).pretty()
        where likes <= 50

    Greater Than
        {<key>:{$gt:<value>}}
        db.mycol.find({"likes":{$gt:50}}).pretty()
        where likes > 50

    Greater Than Equals
        {<key>:{$gte:<value>}}
        db.mycol.find({"likes":{$gte:50}}).pretty()
        where likes >= 50

    Not Equals
        {<key>:{$ne:<value>}}
        db.mycol.find({"likes":{$ne:50}}).pretty()
        where likes != 50

`Mongodb <http://www.yiibai.com/mongodb/mongodb_quick_guide.html>`__

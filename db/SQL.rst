SQL
===

SQL语法
-------

-  数据操作语言 (DML)
-  数据定义语言 (DDL)

DML
~~~

-  SELECT - 从数据库表中获取数据
-  UPDATE - 更新数据库表中的数据
-  DELETE - 从数据库表中删除数据
-  INSERT INTO - 向数据库表中插入数据

DDL
~~~

常用的DDL语句

-  CREATE DATABASE - 创建新数据库
-  ALTER DATABASE - 修改数据库
-  CREATE TABLE - 创建新表
-  ALTER TABLE - 变更（改变）数据库表
-  DROP TABLE - 删除表
-  CREATE INDEX - 创建索引（搜索键）
-  DROP INDEX - 删除索引

创建数据库
~~~~~~~~~~

::

    CREATE DATABASE sql_test

创建表
~~~~~~

指定主键

.. code:: sql

    CREATE TABLE Persons
    (
    Id_P int NOT NULL PRIMARY KEY,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
    )

查看建表语句
^^^^^^^^^^^^

``show create table Persons;``

.. code:: sql

    mysql> show create table Persons\G
    *************************** 1. row ***************************
           Table: Persons
    Create Table: CREATE TABLE `Persons` (
      `Id_P` int(11) NOT NULL AUTO_INCREMENT,
      `LastName` varchar(255) DEFAULT NULL,
      `FirstName` varchar(255) DEFAULT NULL,
      `Address` varchar(255) DEFAULT NULL,
      `City` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`Id_P`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8
    1 row in set (0.00 sec)

ID自增
^^^^^^

.. code:: sql

    CREATE TABLE Persons
    (
    Id_P int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
    )

查看表结构
~~~~~~~~~~

mysql
^^^^^

.. code:: sql

    mysql> desc Persons;
    +-----------+--------------+------+-----+---------+----------------+
    | Field     | Type         | Null | Key | Default | Extra          |
    +-----------+--------------+------+-----+---------+----------------+
    | Id_P      | int(11)      | NO   | PRI | NULL    | auto_increment |
    | LastName  | varchar(255) | YES  |     | NULL    |                |
    | FirstName | varchar(255) | YES  |     | NULL    |                |
    | Address   | varchar(255) | YES  |     | NULL    |                |
    | City      | varchar(255) | YES  |     | NULL    |                |
    +-----------+--------------+------+-----+---------+----------------+
    5 rows in set (0.01 sec)

.. code:: sql

    select * from information_schema.columns where table_schema = 'sql_test' and table_name = 'Persons' ;

INSERT INTO
~~~~~~~~~~~

语法

``INSERT INTO 表名称 VALUES (值1, 值2,....)``

或者指定需要插入数据的列

``INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)``

插入数据

.. code:: sql

    INSERT INTO Persons (LastName,FirstName,Address,City) VALUES ('Gates', 'Bill', 'Xuanwumen 10', 'Beijing')
    INSERT INTO Persons (LastName, Address) VALUES ('Wilson', 'Champs-Elysees')

查看结果

.. code:: sql

    mysql> select * from Persons;
    +------+----------+-----------+----------------+---------+
    | Id_P | LastName | FirstName | Address        | City    |
    +------+----------+-----------+----------------+---------+
    |    1 | Gates    | Bill      | Xuanwumen 10   | Beijing |
    |    2 | Wilson   | NULL      | Champs-Elysees | NULL    |
    +------+----------+-----------+----------------+---------+
    2 rows in set (0.00 sec)

SELECT
~~~~~~

.. code:: sql

    SELECT 列名称 FROM 表名称
    SELECT * FROM 表名称

.. code:: sql

    mysql> SELECT LastName,FirstName FROM Persons;
    +----------+-----------+
    | LastName | FirstName |
    +----------+-----------+
    | Gates    | Bill      |
    | Wilson   | NULL      |
    +----------+-----------+
    2 rows in set (0.00 sec)

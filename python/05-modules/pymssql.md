# pymssql

- [http://www.pymssql.org/en/stable/intro.html](http://www.pymssql.org/en/stable/intro.html)
- [https://pypi.python.org/pypi/pymssql](https://pypi.python.org/pypi/pymssql)

## 先决条件

依赖 [FreeTDS](http://www.freetds.org/)

* Python: Python 2.x: 2.7 or newer. Python 3.x: 3.3 or newer.
* FreeTDS: 0.82 or newer.
* Cython: 0.15 or newer.
* Microsoft SQL Server:
    * 2005 or newer.

安装`FreeTDS`

```shell
# Ubuntu/Debian:

sudo apt-get install freetds-dev

# Mac OS X with Homebrew:

brew install freetds
```

[详细安装方法](http://www.pymssql.org/en/stable/freetds.html#installation)

## 安装

```shell
pip install pymssql
```

下载源码 `.tar.gz`, 或者 `.whl` , [PyPI](https://pypi.python.org/pypi/pymssql)

### mac下安装可能会出现如下报错, `__pyx_r = DBVERSION_80;`

```shell
clang -fno-strict-aliasing -g -O2 -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes -I/usr/local/include -I/usr/local/var/pyenv/versions/2.7.11/include/python2.7 -c _mssql.c -o build/temp.macosx-10.11-x86_64-2.7/_mssql.o -DMSDBLIB
_mssql.c:18783:15: error: use of undeclared identifier 'DBVERSION_80'
    __pyx_r = DBVERSION_80;
              ^
1 error generated.
error: command 'clang' failed with exit status 1
```

原因是安装的freetds版本过高

解决办法:

```shell
# 1
brew unlink freetds; brew install homebrew/versions/freetds091
# 2
pip3 install git+https://github.com/pymssql/pymssql.git
```

## 示例

### 插入数据并查询

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pymssql

# 指定端口
server = "192.168.1.111:2179"
user = "USERNAME"
password = "PASSWORD"

conn = pymssql.connect(server, user, password, "AccessData")
cursor = conn.cursor()
cursor.execute("""
IF OBJECT_ID('persons', 'U') IS NOT NULL
    DROP TABLE persons
CREATE TABLE persons (
    id INT NOT NULL,
    name VARCHAR(100),
    salesrep VARCHAR(100),
    PRIMARY KEY(id)
)
""")
cursor.executemany(
    "INSERT INTO persons VALUES (%d, %s, %s)",
    [(1, 'John Smith', 'John Doe'),
     (2, 'Jane Doe', 'Joe Dog'),
     (3, 'Mike T.', 'Sarah H.')])
# you must call commit() to persist your data if you don't set autocommit to True
conn.commit()

cursor.execute('SELECT * FROM persons WHERE salesrep=%s', 'John Doe')
row = cursor.fetchone()
while row:
    print("ID=%d, Name=%s" % (row[0], row[1]))
    row = cursor.fetchone()

conn.close()
```

### 查询

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pymssql

server = '192.168.1.111:2179'
user = "USERNAME"
password = "PASSWORD"

conn = pymssql.connect(server, user, password, "AccessData")
cursor = conn.cursor()
cursor.execute("""SELECT * FROM t_b_Group WHERE f_GroupName = '技术部\服务器'""")

row = cursor.fetchone()
print(row)
conn.close()
```

### 游标的注意事项

[http://www.pymssql.org/en/stable/pymssql_examples.html#important-note-about-cursors](http://www.pymssql.org/en/stable/pymssql_examples.html#important-note-about-cursors)

任何时候只能有一个游标, 和一个活跃的查询

每一次查询之后, 应该先存储数据, 再进行下一次查询

```python
c1.execute('SELECT ...')
c1_list = c1.fetchall()

c2.execute('SELECT ...')
c2_list = c2.fetchall()

# use c1_list and c2_list here instead of fetching individually from
# c1 and c2
```

### 当处理一个事务的时候

事务没有提交之前, 该连接对数据库的操作, 对其他连接来说是不可见的

Django相关命令
==============

python manage.py
----------------

查看所有命令

Type ‘manage.py help ’ for help on a specific subcommand.

django-admin project mysite
---------------------------

新建项目

如果报错,尝试使用 ``django-admin.py`` 代替 ``django-admin``

python manage.py startapp app
-----------------------------

新建app 前提: 处于项目目录

一个项目可以有多个app,通用的app也可以在多个项目中使用.

app的名字需要为合法的Python包名

创建数据库表,更改数据库表或字段
-------------------------------

Django 1.7.1及以上使用如下命令

如果是之前的版本,Django无法自动更改表结构,迁移数据,不过可以使用第三方工具south

python manage.py makemigrations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

创建更改文件

python manage.py migrate
~~~~~~~~~~~~~~~~~~~~~~~~

将更改应用到数据库

python manage.py runserver
--------------------------

启动 ``web server``

.. code:: python

    # 更改监听端口
    python manage.py runserver 9999

    # 监听所有 ip
    python manage.py runserver 0.0.0.0:8000
    # 如果是外网或者局域网电脑上可以用其它电脑查看web server
    # 访问对应的 ip加端口，比如 http://172.16.20.2:8000

python manage.py flush
----------------------

清空数据库,仅留空表

python manage.py createsuperuser
--------------------------------

创建超级管理员,按照提示输入用户名和对应密码

修改 用户密码

python manage.py changepassword username

导出,导入数据
-------------

.. code:: python

    python manage.py dumpdata appname > appname.json
    python manage.py loaddata appname.json

python manage.py shell
----------------------

Django项目环境终端

python manage.py dbshell
------------------------

数据库命令行

Django 会自动进入在settings.py中设置的数据库，如果是 MySQL 或
postgreSQL,会要求输入数据库用户密码。

在这个终端可以执行数据库的SQL语句。

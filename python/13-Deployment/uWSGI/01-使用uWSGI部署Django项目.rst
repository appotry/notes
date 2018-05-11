UWSGI部署Django项目
===================

-  uWSGI
-  nginx

https://uwsgi.readthedocs.io/en/latest/tutorials/Django_and_nginx.html

web服务器网管接口(Web Server Gateway Interface)
`WSGI <http://wsgi.readthedocs.io/en/latest/>`__ is a Python standard.

.. code:: shell

    the web client <-> the web server <-> the socket <-> uwsgi <-> Django

先决条件
--------

virtualenv
~~~~~~~~~~

可以使用虚拟环境

.. code:: shell

    virtualenv uwsgi-tutorial
    cd uwsgi-tutorial
    source bin/activate

Django
~~~~~~

安装 Django , 创建项目, 并切换到目录:

.. code:: shell

    pip install Django
    django-admin.py startproject mysite
    cd mysite

域名及端口
~~~~~~~~~~

可以自行设置域名(IP), 及端口.

uWSGI安装及简单配置
-------------------

在虚拟环境安装uWSGI
~~~~~~~~~~~~~~~~~~~

.. code:: shell

    pip install uwsgi
    pip3 install uwsgi

基础测试
~~~~~~~~

Basic test

Create a file called test.py:

基本测试
~~~~~~~~

创建\ ``test.py``\ 文件

.. code:: python

    # test.py
    def application(env, start_response):
        start_response('200 OK', [('Content-Type','text/html')])
        return [b"Hello World"] # python3
        # python3依赖 bytes()
        #return ["Hello World"] # python2

运行uWSGI

.. code:: shell

    uwsgi --http :8000 --wsgi-file test.py
    # http :8000: 使用http协议 , 端口 8000
    # wsgi-file test.py: 加载指定文件, test.py

This should serve a ‘hello world’ message directly to the browser on
port 8000. Visit:

`127.0.0.1:8000 <127.0.0.1:8000>`__

如果返回\ ``hello world``, 则以下组件工作正常:

.. code:: shell

    the web client <-> uWSGI <-> Python

测试Django项目
~~~~~~~~~~~~~~

确保项目能够跑起来

.. code:: shell

    python manage.py runserver 0.0.0.0:8000

如果正常, 则可以使用uWSGI尝试

.. code:: shell

    # mysite 即上面创建的Django项目名
    uwsgi --http :8000 --module mysite.wsgi

模块 ``mysite.wsgi`` 表示加载指定的 ``wsgi`` 模块

使用浏览器访问该web服务; 如果可以访问到内容, 则表示 ``uWSGI``
在虚拟环境能够运行Django应用, 如下操作正确:

.. code:: shell

    the web client <-> uWSGI <-> Django

我们通常不会使用浏览器直接访问\ ``uWSGI``, 我们可以在前面加上负载均衡.

Nginx
-----

安装Nginx
~~~~~~~~~

Ubuntu

.. code:: shell

    sudo apt-get install nginx
    sudo /etc/init.d/nginx start    # start nginx

使用浏览器访问\ http://localhost:8080\ 确认Nginx是否可以正常运行,
确定如下组件是否正常工作.

.. code:: shell

    the web client <-> the web server

配置Nginx
~~~~~~~~~

我们需要\ ``uwsgi_params``\ 文件,
https://github.com/nginx/nginx/blob/master/conf/uwsgi_params,
将该文件复制到项目地址

接下来创建\ ``mysite_nginx.conf``

.. code:: shell

    # mysite_nginx.conf

    # the upstream component nginx needs to connect to
    upstream django {
        # server unix:///path/to/your/mysite/mysite.sock; # for a file socket
        server 127.0.0.1:8001; # for a web port socket (we'll use this first)
    }

    # configuration of the server
    server {
        # the port your site will be served on
        listen      8000;
        # the domain name it will serve for
        server_name .example.com; # substitute your machine's IP address or FQDN
        charset     utf-8;

        # max upload size
        client_max_body_size 75M;   # adjust to taste

        # Django media
        location /media  {
            alias /path/to/your/mysite/media;  # your Django project's media files - amend as required
        }

        location /static {
            alias /path/to/your/mysite/static; # your Django project's static files - amend as required
        }

        # Finally, send all non-media requests to the Django server.
        location / {
            uwsgi_pass  django;
            include     /path/to/your/mysite/uwsgi_params; # the uwsgi_params file you installed
        }
    }

创建软链接到 ``/etc/nginx/sites-enabled``:

.. code:: shell

    sudo ln -s ~/path/to/your/mysite/mysite_nginx.conf /etc/nginx/sites-enabled/

部署静态文件
~~~~~~~~~~~~

运行Nginx之前, 需要把Django静态文件放到指定位置, 使用Nginx提供给浏览器.
修改 ``mysite/settings.py``:

.. code:: python

    STATIC_ROOT = os.path.join(BASE_DIR, "static/")

运行

.. code:: shell

    python manage.py collectstatic

测试Nginx
~~~~~~~~~

重启Nginx

.. code:: shell

    sudo /etc/init.d/nginx restart

添加 ``media.png(随便找张图片)`` 到
``/path/to/your/project/project/media``\ 目录,
使用浏览器访问\ http://localhost:8000/media/media.png , 如果正常,
就可以确定Nginx服务正常.

nginx, uWSGI 测试 test.py
-------------------------

.. code:: shell

    # 指定socket , 指定8001端口
    uwsgi --socket :8001 --wsgi-file test.py

访问\ http://localhost:8000\ 测试

.. code:: shell

    the web client <-> the web server <-> the socket <-> uWSGI <-> Python

使用Unix sockets代替端口
------------------------

使用socket更简单, 更好(减少开销)

编辑 ``mysite_nginx.conf``:

.. code:: shell

    server unix:///path/to/your/mysite/mysite.sock; # for a file socket
    # server 127.0.0.1:8001; # for a web port socket (we'll use this first)

重启nginx.

重新运行uWSGI:

.. code:: shell

    uwsgi --socket mysite.sock --wsgi-file test.py
    This time the socket option tells uWSGI which file to use.

浏览器访问\ http://localhost:8000

如果没有工作
~~~~~~~~~~~~

检查 ``nginx error log(/var/log/nginx/error.log)``.

如果看到如下报错

.. code:: shell

    connect() to unix:///path/to/your/mysite/mysite.sock failed (13: Permission
    denied)

你需要设置socket的权限, 让Nginx可以使用它

.. code:: shell

    uwsgi --socket mysite.sock --wsgi-file test.py --chmod-socket=666 # (very permissive)

or:

.. code:: shell

    uwsgi --socket mysite.sock --wsgi-file test.py --chmod-socket=664 # (more sensible)

同时你可能需要切换用户到\ ``nginx``\ 做在组(比如 ``www-data``),
这样Nginx才可能读写你的socket.

根据Nginx日志排除故障.

使用 uwsgi 和 nginx运行 Django 应用
-----------------------------------

.. code:: shell

    uwsgi --socket mysite.sock --module mysite.wsgi --chmod-socket=664

现在你的\ ``Django``\ 应用可以通过\ ``uWSGI``\ 和\ ``nginx``\ 为用户提供服务.

配置 uWSGI 从 .ini文件运行
--------------------------

通过配置文件运行, 可以使你的维护异常简单

创建文件 ``mysite_uwsgi.ini``:

.. code:: shell

    # mysite_uwsgi.ini file
    [uwsgi]

    # Django-related settings
    # the base directory (full path)
    chdir           = /path/to/your/project
    # Django's wsgi file
    module          = project.wsgi
    # the virtualenv (full path)
    home            = /path/to/virtualenv

    # process-related settings
    # master
    master          = true
    # maximum number of worker processes
    processes       = 10
    # the socket (use the full path to be safe
    socket          = /path/to/your/project/mysite.sock
    # ... with appropriate permissions - may be needed
    # chmod-socket    = 664
    # clear environment on exit
    vacuum          = true

使用该文件运行 uswgi:

.. code:: shell

    uwsgi --ini mysite_uwsgi.ini # the --ini option is used to specify a file

测试Django站点

直接在系统上安装uWSGI
---------------------

到此为止, uWSGI安装在虚拟环境;有时候我们需要直接在系统安装.

退出虚拟环境:

.. code:: shell

    deactivate

安装uWSGI

.. code:: shell

    sudo pip install uwsgi

    # Or install LTS (long term support).
    pip install https://projects.unbit.it/downloads/uwsgi-lts.tar.gz

运行并检查

.. code:: shell

    uwsgi --ini mysite_uwsgi.ini # the --ini option is used to specify a file

君主模式
--------

uWSGI可以运行在君主模式下, 该模式uWSGI会监视配置文件目录,
并为所有文件启动实例

当一个配置文件被修改时, uWSGI会自动重启对应实例

.. code:: shell

    # create a directory for the vassals
    sudo mkdir /etc/uwsgi
    sudo mkdir /etc/uwsgi/vassals
    # symlink from the default config directory to your config file
    sudo ln -s /path/to/your/mysite/mysite_uwsgi.ini /etc/uwsgi/vassals/
    # run the emperor
    uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data

你可能需要使用sudo运行

.. code:: shell

    sudo uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data
    # emperor: where to look for vassals (config files)
    # uid: the user id of the process once it’s started
    # gid: the group id of the process once it’s started

检查站点

系统启动是运行uWSGI
-------------------

使用 ``rc.local`` file.

编辑\ ``/etc/rc.local``\ 添加:

.. code:: shell

    # 在 “exit 0” 行前添加.
    /usr/local/bin/uwsgi --emperor /etc/uwsgi/vassals --uid www-data --gid www-data --daemonize /var/log/uwsgi-emperor.log

更多配置
--------

参考对应应用文档

-  `Nginx <http://nginx.org/en/docs/>`__
-  `uWSGI <https://uwsgi-docs.readthedocs.io/en/latest/>`__

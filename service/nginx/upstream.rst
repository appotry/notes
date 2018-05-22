upstream
========

1、轮询
-------

2、加权循环
-----------

-  weight=number默认是加权循环，先按weight的权重分配，
-  max_fails最大失败次数2次，失败超时时间30s，失败找其他的机器
   默认权重是1
-  fail_timeout 超时失败时间
-  backup 之前所有的访问都失效开始尝试backup

.. code:: shell

    upstream backend {
      server 127.0.0.1:8080 weight=1 max_fails=2 fail_timeout=30s;
      server 192.168.1.1:8080 weight=1 max_fails=2 fail_timeout=30s backup;
    }

3、ip_hash
----------

ip_hash确保同一个客户端的ip每次都去同一台服务器

down 当前server不参加负载

.. code:: shell

    upstream backend {
        ip_hash;

        server backend1.example.com;
        server backend2.example.com;
        server backend3.example.com down;
        server backend4.example.com;
    }

4、hash
-------

5、least_conn
-------------

最小活动连接数，权重的负载均衡

.. code:: shell

    upstream backend {
        least_conn;

        server backend1.example.com;
        server backend2.example.com;
    }

6、least_time header|last_byte;
-------------------------------

响应时间最短，活动连接数

.. code:: shell

    upstream backend {
        least_time header;

        server backend1.example.com;
        server backend2.example.com;
    }

推荐使用：加权循环
------------------

.. code:: shell

    upstream backend {
      server 127.0.0.1:8080 weight=1 max_fails=2 fail_timeout=30s;
      server 192.168.1.1:8080 weight=1 max_fails=2 fail_timeout=30s backup;
    }

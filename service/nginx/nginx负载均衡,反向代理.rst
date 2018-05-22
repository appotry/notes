Nginx负载均衡，反向代理
=======================

-  `Nginx负载均衡，反向代理 <#nginx负载均衡反向代理>`__

   -  `upstream <#upstream>`__

      -  `负载均衡方式 <#负载均衡方式>`__

         -  `round-robin（默认） <#round-robin默认>`__
         -  `weight（权重） <#weight权重>`__
         -  `least_conn（最小连接数） <#least_conn最小连接数>`__
         -  `least_time （最小响应时间） <#least_time-最小响应时间>`__
         -  `hash <#hash>`__
         -  `ip_hash（访问ip） <#ip_hash访问ip>`__
         -  `fair（第三方） <#fair第三方>`__
         -  `url_hash（第三方） <#url_hash第三方>`__
         -  `一致性hash <#一致性hash>`__

   -  `proxy <#proxy>`__

      -  `正向代理 <#正向代理>`__
      -  `反向代理 <#反向代理>`__

   -  `使用request_body记录POST请求日志 <#使用request_body记录post请求日志>`__
   -  `完整配置 <#完整配置>`__

upstream
--------

简单配置

1. 在http标签下，添加upstream

.. code:: shell

        upstream linuxidc {
            server 10.0.0.10:7080;
            server 10.0.0.20:8980;
        }

2. 配置proxy_pass

.. code:: shell

        location / {
                    root  html;
                    index  index.html index.htm;
                    proxy_pass http://linuxidc;
        }

The address can also be specified using variables (1.11.3):

::

    proxy_pass $upstream;

负载均衡方式
~~~~~~~~~~~~

round-robin(默认)
^^^^^^^^^^^^^^^^^

每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器down掉，能自动剔除。虽然这种方式简便、成本低廉。
缺点是：可靠性低和负载分配不均衡。适用于图片服务器集群和纯静态页面服务器集群。

weight(权重)
^^^^^^^^^^^^

::

    指定轮询几率，weight和访问比率成正比，用于后端服务器性能不均的情况。默认为1

    upstream linuxidc{
        server 10.0.0.77 weight=5;
        server 10.0.0.88 weight=10;
    }

按权重轮询的方式,服务器是随机的,分散后按权重比重分配

.. code:: shell

    ➜  nginx-cs for n in {1..10};do curl 127.0.0.1:60000;done
    82   3
    81   6
    83   1
    81   6
    82   3
    81   6
    81   6
    82   3
    81   6
    81   6

测试配置

.. code:: shell

    ➜  conf.d ls
    81.conf      82.conf      83.conf      default.conf
    ➜  conf.d cat -n *
         1  server {
         2      listen       81;
         3      server_name  localhost;
         4      location / {
         5          root   /usr/share/nginx/html;
         6          index  81index.html ;
         7      }
         8  }
         1  server {
         2      listen       82;
         3      server_name  localhost;
         4      location / {
         5          root   /usr/share/nginx/html;
         6          index  82index.html ;
         7      }
         8  }
         1  server {
         2      listen       83;
         3      server_name  localhost;
         4      location / {
         5          root   /usr/share/nginx/html;
         6          index  83index.html ;
         7      }
         8  }
         1  upstream yang.com {
         2          server 127.0.0.1:81 weight=6;
         3          server 127.0.0.1:82 weight=3;
         4          server 127.0.0.1:83 weight=1;
         5  }
         6  server {
         7      listen       80;
         8      server_name  _;
         9
        10      location / {
        11          proxy_pass http://yang.com;
        12      }
        13  }

least_conn(最小连接数)
^^^^^^^^^^^^^^^^^^^^^^

::

    请求发送到激活连接数最少的服务器，服务器权重也会成为选择因素

    upstream backend {
        least_conn;
        server backend1.example.com;
        server backend2.example.com;
    }

least_time(最小响应时间)
^^^^^^^^^^^^^^^^^^^^^^^^

::

    least_time header | last_byte;

    header表示是计算从后台返回的第一个字节，last_byte计算的是从后台返回的所有数据时间

    请求发送到具有最短平均响应时间和最少活动连接数的服务器，同时考虑服务器的权重。如果有几个这样的服务器，则使用加权循环平衡方法依次尝试它们.

hash
^^^^

::

    请求发送到哪个服务器取决于一个用户端定义的关键词，如文本，变量或两者组合。例如，这个关键词可以是来源IP和端口，或者URI：

    upstream backend {
        hash $request_uri consistent;
        server backend1.example.com;
        server backend2.example.com;
    }

ip_hash(访问ip)
^^^^^^^^^^^^^^^

::

    每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session的问题。

    upstream favresin{
        ip_hash;
        server 10.0.0.10:8080;
        server 10.0.0.11:8080;
    }

fair(第三方)
^^^^^^^^^^^^

::

    按后端服务器的响应时间来分配请求，响应时间短的优先分配。与weight分配策略类似。

    upstream favresin{
        server 10.0.0.10:8080;
        server 10.0.0.11:8080;
        fair;
    }

url_hash(第三方)
^^^^^^^^^^^^^^^^

::

    按访问url的hash结果来分配请求，使每个url定向到同一个后端服务器，后端服务器为缓存时比较有效。

    注意：在upstream中加入hash语句，server语句中不能写入weight等其他的参数，hash_method是使用的hash算法。

    upstream resinserver{
        server 10.0.0.10:7777;
        server 10.0.0.11:8888;
        hash $request_uri;
        hash_method crc32;
    }

一致性hash
^^^^^^^^^^

upstream一些参数的含义分别如下：

-  ``weight=number`` 设置权重, 默认为1。weight越大，负载的权重就越大。
-  ``down``: 表示当前的server暂时不参与负载.
-  ``max_fails``:
   允许请求失败的次数默认为1.当超过最大次数时，返回proxy_next_upstream
   模块定义的错误.
-  ``fail_timeout``: max_fails次失败后，暂停的时间。
-  ``backup``:
   其它所有的非backup机器down或者忙的时候，请求backup机器。所以这台机器压力会最轻。
-  ``resolve``:
   监视与服务器的域名对应的IP地址的改变，并自动修改上游配置，而不需要重新启动nginx。服务器组必须驻留在共享内存中。
-  ``slow_start=time``:设置服务器将其权重从零恢复到标称值的时间，当不正常服务器变得正常时，或者当服务器在一段时间之后变为可用时，其被认为不可用。默认值为零，即禁用慢启动。

proxy
-----

http代理，以及通过TCP、UDP、UNIX-domain sockets的方式代理数据流

`Module
ngx_http_proxy_module <http://nginx.org/en/docs/http/ngx_http_proxy_module.html>`__
`Module
ngx_stream_proxy_module <http://nginx.org/en/docs/stream/ngx_stream_proxy_module.html#proxy_pass>`__

正向代理
~~~~~~~~

配置文件示例

.. code:: shell

    server {
        listen 10.0.0.136:80;
        location / {
            resolver 10.0.0.200; # DNS服务器IP地址，可以指定多个，以轮训方式请求
            resolver_timeout 30s;  # 解析超时时间
            proxy_pass http://$http_host$request_uri;
            }
    }

客户端访问

::

    export http_proxy=http://10.0.0.136:80  # 设定环境变量，指定代理服务器的ip及端口，或者浏览器中添加代理服务器IP地址

反向代理
~~~~~~~~

配置文件示例

::

    server {
        listen       80;
        server_name  10.0.0.136; #根据环境介绍，nginx server ip

        location / {
            proxy_pass http://10.0.0.137; #被代理的服务器ip
                    }

        location /web2 {                            #多个location
            proxy_pass http://10.0.0.111;
            proxy_set_header  X-Real-IP  $remote_addr;
                    }
    }

    proxy_set_header Host $host;
    proxy_set_header X-Forward-For $remote_addr;

使用request_body记录POST请求日志
--------------------------------

添加$request_body字段

常规不带request_body

::

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

带request_body

::

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" $request_body '
                      '"$http_user_agent" "$http_x_forwarded_for"';


     log_format json '{'
                     '"remote_addr":"$remote_addr",'
                     '"remote_user":"$remote_user",'
                     '"time_local":"$time_local",'
                     '"@timestamp":"$time_iso8601",'
                     '"@source":"$server_addr",'
                     '"request_method":"$request_method",'
                     '"request":"$request",'
                     #'"request_body":"$request_body",'
                     '"uri":"$uri",'
                     '"request_uri":"$request_uri",'
                     '"status":$status,'
                     '"body_bytes_sent":$body_bytes_sent,'
                     '"http_referer":"$http_referer",'
                     '"http_user_agent":"$http_user_agent",'
                     '"http_x_forwarded_for":"$http_x_forwarded_for",'
                     '"request_time":$request_time,'
                     '"upstream_response_time":"$upstream_response_time",'
                     '"upstream_status":"$upstream_status",'
                     '"upstream_addr":"$upstream_addr"'
                     '}';

完整配置
--------

.. code:: shell

    root@ubuntu75:/etc/nginx# egrep -v "^#|^$" nginx.conf
    user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    events {
        worker_connections 768;
    }
    http {

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        log_format main  '$remote_addr - $remote_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" $request_body '
                         '"$http_user_agent" "$http_x_forwarded_for"';
        log_format json  '{'
                         '"remote_addr":"$remote_addr",'
                         '"remote_user":"$remote_user",'
                         '"time_local":"$time_local",'
                         '"@timestamp":"$time_iso8601",'
                         '"@source":"$server_addr",'
                         '"request_method":"$request_method",'
                         '"request":"$request",'
                         #'"request_body":"$request_body",'
                         '"uri":"$uri",'
                         '"request_uri":"$request_uri",'
                         '"status":$status,'
                         '"body_bytes_sent":$body_bytes_sent,'
                         '"http_referer":"$http_referer",'
                         '"http_user_agent":"$http_user_agent",'
                         '"http_x_forwarded_for":"$http_x_forwarded_for",'
                         '"request_time":$request_time,'
                         '"upstream_response_time":"$upstream_response_time",'
                         '"upstream_status":"$upstream_status",'
                         '"upstream_addr":"$upstream_addr"'
                         '}';
        access_log /var/log/nginx/access.log json;
        error_log /var/log/nginx/error.log ;

        gzip on;
        gzip_disable "msie6";

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
    }

.. code:: shell

    root@ubuntu75:/etc/nginx/conf.d# cat kibana.conf
    server {
        listen 80;
        server_name _;
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/htpasswd.users;

        location / {
            proxy_pass http://127.0.0.1:5601;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }

Nginx配置
=========

主配置文件
----------

    日志使用json格式

.. code:: shell

    root@ubuntu75:/etc/nginx# egrep -v "^$|#" nginx.conf
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
        ssl_prefer_server_ciphers on;
         log_format json '{'
                         '"remote_addr":"$remote_addr",'
                         '"remote_user":"$remote_user",'
                         '"time_local":"$time_local",'
                         '"@timestamp":"$time_iso8601",'
                         '"@source":"$server_addr",'
                         '"request_method":"$request_method",'
                         '"request":"$request",'
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

转发请求到本地5601
------------------

.. code:: shell

    root@ubuntu75:/etc/nginx# cat conf.d/kibana.conf
    server {
        listen 80;
        server_name _;
    #    auth_basic "Restricted Access";
    #    auth_basic_user_file /etc/nginx/htpasswd.users;

        location / {
            proxy_pass http://127.0.0.1:5601;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }

添加密码认证
------------

    使用htpasswd生成用户名及对应密码文件

.. code:: shell

    root@ubuntu75:/etc/nginx# htpasswd -c /etc/nginx/htpasswd.users yjj
    New password:
    Re-type new password:
    Adding password for user yjj

    运行nginx的用户需要有密码文件的读权限

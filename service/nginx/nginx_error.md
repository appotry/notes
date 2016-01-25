# nginx故障集锦

## 1 nginx 403 forbidden多种原因及故障模拟重现

基础环境

``` bash
[root@ruin ~]# cat /etc/redhat-release
CentOS release 6.6 (Final)
[root@ruin ~]# uname -a
Linux ruin 2.6.32-504.el6.x86_64 #1 SMP Wed Oct 15 04:27:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
[root@ruin ~]# ifconfig|sed -n '2p'|awk -F'[ :]+' '{print $4}'
10.0.11.103
[root@ruin ~]# tail -1 /etc/hosts
10.0.11.103 www.liurui.space

[root@ruin ~]# yum install nginx -y
[root@ruin ~]# nginx -v
nginx version: nginx/1.10.2
[root@ruin ~]# /etc/init.d/nginx start
[root@ruin ~]# netstat -lntp|grep 80
tcp        0      0 0.0.0.0:80                  0.0.0.0:*                   LISTEN      60788/nginx
tcp        0      0 :::80                       :::*                        LISTEN      60788/nginx
```

### 1.1 nginx站点目录下没有配置文件里指定的首页文件

``` bash
[root@ruin ~]# vim /etc/nginx/conf.d/liurui.conf
   server {
       listen       80;
       server_name  www.liurui.space;
       location / {
           root   /data/www;
           index  index.html index.htm;#<==配置首页文件配置
       }
       access_log off;
   }

[root@ruin ~]# mkdir -p /data/www
[root@ruin ~]# echo "this is a test index.html" >>/data/www/index.html
[root@ruin ~]# ls /data/www/
index.html     #<==存在首页文件
[root@ruin ~]# nginx -t
[root@ruin ~]# nginx -s reload
[root@ruin ~]# curl www.liurui.space
this is a test index.html

[root@ruin ~]# mv /data/www/index.html /tmp/ <==移除首页文件
[root@ruin ~]# curl -I -s www.liurui.space|head -1
HTTP/1.1 403 Forbidden
```

当没有首页文件时可以使用参数**autoindex on;**,当找不到首页文件时，会展示目录结构，这个功能一般不要用除非有需求。

``` bash
[root@ruin ~]# vi /etc/nginx/conf.d/liurui.conf
   server {
       listen       80;
       server_name  www.liurui.space;
       location / {
           root   /data/www;
           #index  index.html index.htm;#<==配置首页文件配置
           autoindex on;
       }
       access_log off;
   }

[root@ruin ~]# nginx -t
[root@ruin ~]# nginx -s reload
[root@ruin ~]# curl www.liurui.space
<html>
<head><title>Index of /</title></head>
<body bgcolor="white">
<h1>Index of /</h1><hr><pre><a href="../">../</a>
</pre><hr></body>
</html>

[root@ruin ~]# curl -I -s www.liurui.space
HTTP/1.1 200 OK
Server: nginx/1.10.2
Date: Thu, 05 Jan 2017 07:17:35 GMT
Content-Type: text/html
Connection: keep-alive
```

### 1.2 站点目录或内部的程序文件没有nginx用户访问权限

``` bash
[root@ruin ~]# cat /etc/nginx/conf.d/liurui.conf
   server {
       listen       80;
       server_name  www.liurui.space;
       location / {
           root   /data/www;
           index  index.html index.htm;#<==配置首页文件配置
       }
       access_log off;
   }

[root@ruin ~]# cat /data/www/index.html
this is a test index.html
[root@ruin ~]# curl -I -s www.liurui.space|head -1
HTTP/1.1 200 OK

[root@ruin ~]# chmod 700 /data/www/index.html
[root@ruin ~]# curl -I -s www.liurui.space|head -1
HTTP/1.1 403 Forbidden
[root@ruin ~]# chmod 644 /data/www/index.html
[root@ruin ~]# curl -I -s www.liurui.space|head -1
HTTP/1.1 200 OK
```

### 1.3 nginx配置文件中设置allow、deny等权限控制，导致客户端没有没权限访问。

``` bash
[root@ruin ~]# cat /etc/nginx/conf.d/liurui.conf
   server {
       listen       80;
       server_name  www.liurui.space;
       location / {
           root   /data/www;
           index  index.html index.htm;#<==配置首页文件配置
           allow  192.168.1.0/24;
           deny  all;
       }
       access_log off;
   }
[root@ruin ~]# nginx -t
[root@ruin ~]# nginx -s reload
[root@ruin ~]# curl -I -s www.liurui.space|head -1
HTTP/1.1 403 Forbidden
```

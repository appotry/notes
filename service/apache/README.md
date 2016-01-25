# apache

## Apache-2.4.23安装方法

### 下载

[http://apr.apache.org/download.cgi](http://apr.apache.org/download.cgi)

```shell
[root@web src]# pwd
/root/src
[root@web src]# wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-1.5.2.tar.gz
[root@web src]# wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-1.5.4.tar.gz

yum install pcre-devel openssl-devel -y
```

安装apr-1.5.2，低版本会安装不上event模块。

```shell
[root@web src]# ls
apr-1.5.2.tar.gz  apr-util-1.5.4.tar.gz  httpd-2.4.23  httpd-2.4.23.tar.gz
[root@web src]# tar xf apr-1.5.2.tar.gz
[root@web src]# cd apr-1.5.2
[root@web apr-1.5.2]# ./configure --prefix=/usr/local/apr-1.5.2
[root@web apr-1.5.2]# make && make install
```

安装apr-util-1.5.4.

```shell
./configure --prefix=/usr/local/apr1.5 --with-apr=/usr/local/apr1.5
#这个是apr的工具集，它依赖于上面的那个apr， 所以加上--with来指定我们安装apr的目录。
[root@web apr-util-1.5.4]# ./configure --prefix=/usr/local/apr-util-1.5.4 --with-apr=/usr/local/apr-1.5.2
[root@web apr-util-1.5.4]# make && make install

[root@web httpd-2.4.23]# ./configure --prefix=/application/apache-2.4.23 --enable-so --enable-ssl --enable-rewrite --enable-cgi --with-zlib --with-pcre --with-apr=/usr/local/apr-1.5.2/ --with-apr-util=/usr/local/apr-util-1.5.4/ --enable-modules=most --enable-mpms-shared=all --with-mpm=worker
[root@web httpd-2.4.23]# make && make install

ln -s /application/apache-2.4.23/ /application/apache
cd /application/apache/htdocs/
mkdir -p bbs www blog
echo 'apache www' >www/index.html
echo 'apache bbs' >bbs/index.html
echo 'apache blog' >blog/index.html
```

### httpd2.4配置文件：

```shell
# /etc/httpd24    ：编译安装时指定的配置文件目录；
# /etc/httpd24/httpd.conf    ：主配置文件
# /etc/httpd24/extra/httpd-default.conf    ：默认配置文件，keepalive、AccessFileName等设置；
# /etc/httpd24/extra/httpd-userdir.conf    ：用户目录配置文件；
# /etc/httpd24/extra/httpd-mpm.conf    ：MPM配置文件；
# /etc/httpd24/extra/httpd-ssl.conf    ：SSL配置文件，为站点提供https协议；
# /etc/httpd24/extra/httpd-vhosts.conf    ：虚拟主机配置文件；
# /etc/httpd24/extra/httpd-info.conf    ：server-status页面配置文件；
```

### php

```shell
yum install zlib-devel libxml2-devel libjpeg-devel libiconv-devel -y
yum install freetype-devel libpng-devel gd-devel curl-devel libxslt-devel -y
yum -y install libmcrypt-devel mhash mhash-devel mcrypt -y
yum install libxslt-devel -y
yum install openssl-devel -y


wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
tar zxf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure --prefix=/usr/local/libiconv
make
make install
```

```shell
./configure \
--prefix=/application/php-5.5.38 \
--with-apxs2=/application/apache/bin/apxs \
--with-mysql=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv-dir=/usr/local/libiconv \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--with-mcrypt \
--with-gd \
--enable-gd-native-ttf \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-soap \
--enable-short-tags \
--enable-static \
--with-xsl \
--enable-ftp


make
make install
ln -s /application/php-5.5.38/ /application/php
ls /application/php/
```

### 配置

```shell
<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>
```

## 问题

```shell
[root@web application]# ./apache/bin/apachectl stop
[Mon Oct 17 11:28:42.619595 2016] [:crit] [pid 54470:tid 140324353431296] Apache is running a threaded MPM, but your PHP Module is not compiled to be threadsafe.  You need to recompile PHP.
AH00013: Pre-configuration failed
```

```shell
在linux下编译，配合此版本，php需去掉--with-openssl 参数。
```

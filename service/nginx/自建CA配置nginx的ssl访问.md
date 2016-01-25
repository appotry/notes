# 自建CA,配置nginx的https访问

openssl是一个开源程序的套件、这个套件有三个部分组成：一是libcryto，这是一个具有通用功能的加密库，里面实现了众多的加密库；二是libssl，这个是实现ssl机制的，它是用于实现TLS/SSL的功能；三是openssl，是个多功能命令行工具，它可以实现加密解密，甚至还可以当CA来用，可以让你创建证书、吊销证书。

默认情况ubuntu和CentOS上都已安装好openssl。CentOS 6.x 上有关ssl证书的目录结构：

``` bash
/etc/pki/CA/
            certs
            crl         吊销的证书
            newcerts    存放CA签署（颁发）过的数字证书（证书备份目录）
            private     用于存放CA的私钥

/etc/pki/tls/
             cert.pem    软链接到certs/ca-bundle.crt
             certs/      该服务器上的证书存放目录，可以房子自己的证书和内置证书
             ca-bundle.crt    内置信任的证书
             private    证书密钥存放目录
             openssl.cnf    openssl的CA主配置文件
```

## 1 自建CA

系统环境

``` bash
[root@ruin ~]# cat /etc/redhat-release
CentOS release 6.6 (Final)

[root@ruin ~]# uname -a
Linux ruin 2.6.32-504.el6.x86_64 #1 SMP Wed Oct 15 04:27:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

[root@ruin ~]# ifconfig|sed -n '2p'|awk -F'[ :]+' '{print $4}'
10.0.11.102
```

### 1.1 修改CA的一些配置文件

CA要给别人颁发证书，首先自己得有一个作为根证书，我们得在一切工作之前修改好CA的配置文件、序列号、索引等等。

``` bash
[root@ruin ~]# vi /etc/pki/tls/openssl.cnf
[ CA_default ]

dir             = /etc/pki/CA           # Where everything is kept
certs           = $dir/certs            # Where the issued certs are kept
crl_dir         = $dir/crl              # Where the issued crl are kept
database        = $dir/index.txt        # database index file.
#unique_subject = no                    # Set to 'no' to allow creation of
                                        # several ctificates with same subject.
new_certs_dir   = $dir/newcerts         # default place for new certs.

certificate     = $dir/cacert.pem       # The CA certificate
serial          = $dir/serial           # The current serial number
crlnumber       = $dir/crlnumber        # the current crl number
                                        # must be commented out to leave a V1 CRL
crl             = $dir/crl.pem          # The current CRL
private_key     = $dir/private/cakey.pem# The private key
RANDFILE        = $dir/private/.rand    # private random number file
```

创建两个初始文件
``` bash
[root@ruin ~]# touch /etc/pki/CA/{serial,index.txt}
[root@ruin ~]# echo 01 > /etc/pki/CA/serial
```

### 1.2 生成根密钥

安全起见，修改cakey.pem私钥文件权限为600或400,在子shell中执行该命令 umask 077不影响当前shell的umask

``` bash
[root@ruin ~]# (umask 077;openssl genrsa -out /etc/pki/CA/private/cakey.pem 1024)
[root@ruin ~]# ll /etc/pki/CA/private/cakey.pem
-rw------- 1 root root 1675 1月  12 16:41 /etc/pki/CA/private/cakey.pem
```

### 1.3 生成根证书

使用req命令生成自签证书：

``` bash
[root@ruin ~]# openssl req -new -x509 -key /etc/pki/CA/private/cakey.pem -out /etc/pki/CA/cacert.pem -days 3650
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [CN]:CN
State or Province Name (full name) []:北京
Locality Name (eg, city) [Default City]:北京
Organization Name (eg, company) [Default Company Ltd]:北京九歌
Organizational Unit Name (eg, section) []:jiuge
Common Name (eg, your name or your server's hostname) []:51mcp.com
Email Address []:
```
会提示输入一些内容，因为是私有的，所以可以随便输入（之前修改的openssl.cnf会在这里呈现），最好记住能与后面保持一致。
上面的自签证书cacert.pem应该生成在/etc/pki/CA下。

## 2 nginx 配置ssl密钥

### 2.1  nginx生成key

以上都是在CA服务器上做的操作，而且只需进行一次，现在转到nginx服务器上执行：

nginx服务器基础环境

``` bash
[root@ruin ~]# cat /etc/redhat-release
CentOS release 6.6 (Final)

[root@ruin ~]# uname -a
Linux ruin 2.6.32-504.el6.x86_64 #1 SMP Wed Oct 15 04:27:16 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

[root@ruin ~]# ifconfig|sed -n '2p'|awk -F'[ :]+' '{print $4}'
10.0.11.103
```

``` bash
[root@ruin ~]# rpm -qa nginx
nginx-1.10.2-1.el6.x86_64
[root@ruin ~]# mkdir /etc/nginx/ssl -p
[root@ruin ~]# (umask 077;openssl genrsa -out /etc/nginx/ssl/nginx.key 1024)
[root@ruin ~]# ll /etc/nginx/ssl/nginx.key
-rw------- 1 root root 1679 1月  12 16:57 /etc/nginx/ssl/nginx.key
```

### 2.2 为nginx生成证书签署请求（信息填写和上面自建CA一样）

``` bash
[root@ruin ~]# openssl req -new -key /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.csr -days 3650
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:CN
State or Province Name (full name) []:北京
Locality Name (eg, city) [Default City]:北京
Organization Name (eg, company) [Default Company Ltd]:北京九歌
Organizational Unit Name (eg, section) []:jiuge
Common Name (eg, your name or your server's hostname) []:51mcp.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

### 2.3 将请求通过可靠方式发送给CA主机

``` bash
[root@ruin ~]# scp /etc/nginx/ssl/nginx.csr root@10.0.11.102:/tmp
```

### 2.4 私有CA服务器根据请求来签署证书

``` bash
[root@ruin ~]# openssl ca -in /tmp/nginx.csr -out /etc/pki/CA/certs/nginx.crt -days 3650
Using configuration from /etc/pki/tls/openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number: 1 (0x1)
        Validity
            Not Before: Jan 12 09:17:58 2017 GMT
            Not After : Jan 10 09:17:58 2027 GMT
        Subject:
            countryName               = CN
            stateOrProvinceName       = \E5\8C\97\E4\BA\AC
            organizationName          = \E5\8C\97\E4\BA\AC\E4\B9\9D\E6\AD\8C
            organizationalUnitName    = jiuge
            commonName                = 51mcp.com
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                6D:A4:3F:D0:74:AF:3B:7C:BE:0C:AD:6A:33:C3:12:59:11:C8:10:B0
            X509v3 Authority Key Identifier:
                keyid:DA:63:5D:6A:CD:AE:64:50:B8:61:E5:44:0A:BC:65:05:8D:FE:41:CF

Certificate is to be certified until Jan 10 09:17:58 2027 GMT (3650 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
```

### 2.5 将证书发送给申请者

``` bash
[root@ruin ~]# scp /etc/pki/CA/certs/nginx.crt root@10.0.11.103:/etc/nginx/ssl/
```

## 3 配置nginx https加密

### 3.1 修改ssl.conf配置文件

``` bash
[root@ruin conf.d]# vim /etc/nginx/conf.d/ssl.conf
server {
   listen 443;
   server_name 10.0.11.103;

   root /data/www;
   index index.html index.htm;

   ssl on;
   ssl_certificate /etc/nginx/ssl/nginx.crt;
   ssl_certificate_key /etc/nginx/ssl/nginx.key;

#    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
#    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
#    ssl_prefer_server_ciphers on;

}
```

### 3.2 创建ssl目录首页

``` bash
[root@ruin ~]# mkdir /data/www -p
[root@ruin ~]# echo 'test ssl is ok!' >/data/www/index.html
```

### 3.3 修改主配置强制跳转之https

``` bash
[root@ruin ~]# vim /etc/nginx/conf.d/default.conf
[root@ruin ~]# egrep -v "#|^$" /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  10.0.11.103;
    root         /usr/share/nginx/html;
    include /etc/nginx/default.d/*.conf;
    return 301 https://$server_name$request_uri;
    location / {
    }
    error_page 404 /404.html;
        location = /40x.html {
    }
    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }
}
```

### 3.4 检查重启nginx打开浏览器测试

``` bash
[root@ruin ~]# nginx -t
[root@ruin ~]# nginx -s reload
```

参考：
[基于OpenSSL自建CA和颁发SSL证书](http://seanlook.com/2015/01/18/openssl-self-sign-ca/)
[在Nginx服务器中启用SSL的配置方法](http://www.jb51.net/article/70640.htm)

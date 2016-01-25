# search-guard 5

[Search Guard](https://floragunn.com/searchguard/)

[Search Guard GitHub](https://github.com/floragunncom/search-guard)

[Search Guard SSL](https://github.com/floragunncom/search-guard-ssl)

## Table of content

<!-- TOC -->

- [search-guard 5](#search-guard-5)
    - [Table of content](#table-of-content)
    - [安装](#安装)
- [Search Guard 插件配置](#search-guard-插件配置)
    - [生成密钥库和信任库](#生成密钥库和信任库)
        - [修改`gen_node_cert.sh`](#修改gen_node_certsh)
        - [修改脚本`gen_client_node_cert.sh`,生成sgadmin keystore password,kirk keystore password](#修改脚本gen_client_node_certsh生成sgadmin-keystore-passwordkirk-keystore-password)
    - [配置elasticsearch](#配置elasticsearch)
        - [复制密钥库和信任库文件](#复制密钥库和信任库文件)
        - [node-1 配置插件](#node-1-配置插件)
            - [配置HTTPS](#配置https)
    - [配置search guard](#配置search-guard)
    - [配置logstash](#配置logstash)
    - [配置kibana](#配置kibana)
    - [配置sgadmin限制权限](#配置sgadmin限制权限)
    - [执行sgtool](#执行sgtool)

<!-- /TOC -->

## 安装

安装配置Search Guard之前,需要先确定es集群能够健康的跑起来

网络可能比较慢,会出现下载超级慢的情况,多试N变就好,特殊情况可考虑翻墙试试...

```shell
# 具体版本号,参考Search Guard GitHub Tag
root@ubuntu47:/usr/share/elasticsearch# bin/elasticsearch-plugin install -b com.floragunn:search-guard-5:5.0.0-9
-> Downloading com.floragunn:search-guard-5:5.0.0-9 from maven central
[=================================================] 100%??
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@     WARNING: plugin requires additional permissions     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
* java.lang.RuntimePermission accessClassInPackage.sun.misc
* java.lang.RuntimePermission accessDeclaredMembers
* java.lang.RuntimePermission getClassLoader
* java.lang.RuntimePermission loadLibrary.*
* java.lang.RuntimePermission setContextClassLoader
* java.lang.RuntimePermission shutdownHooks
* java.lang.reflect.ReflectPermission suppressAccessChecks
* java.security.SecurityPermission getProperty.ssl.KeyManagerFactory.algorithm
* java.util.PropertyPermission java.security.krb5.conf write
* java.util.PropertyPermission javax.security.auth.useSubjectCredsOnly write
* javax.security.auth.AuthPermission doAs
* javax.security.auth.AuthPermission modifyPrivateCredentials
* javax.security.auth.kerberos.ServicePermission * accept
See http://docs.oracle.com/javase/8/docs/technotes/guides/security/permissions.html
for descriptions of what these permissions allow and the associated risks.
-> Installed search-guard-5
```

# Search Guard 插件配置

## 生成密钥库和信任库

5.0之后,插件目录会带如下脚本

在github上下载生成密钥的脚本,或者**使用本项目里已经修改过的脚本**,具体修改内容没有详细描述得可以对文件进行对比

    git clone https://github.com/floragunncom/search-guard-ssl.git

    https://github.com/floragunncom/search-guard-ssl/tree/master/example-pki-scripts

下载下来的脚本需要修改后使用

```shell
root@ubuntu47:~/src/search-guard-ssl/test# ls search-guard-ssl/example-pki-scripts/ -l
total 28
-rwxr-xr-x 1 root root  141 Mar 17 17:12 clean.sh
drwxr-xr-x 2 root root 4096 Mar 17 17:12 etc
-rwxr-xr-x 1 root root  411 Mar 17 17:12 example.sh               # 通过此脚本创建所有证书
-rwxr-xr-x 1 root root 2286 Mar 17 17:12 gen_client_node_cert.sh  # 创建客户端证书
-rwxr-xr-x 1 root root 2746 Mar 17 17:12 gen_node_cert.sh         # 创建节点证书
-rwxr-xr-x 1 root root 1764 Mar 17 17:12 gen_node_cert_openssl.sh
-rwxr-xr-x 1 root root 1993 Mar 17 17:12 gen_root_ca.sh           # 创建根证书
```

脚本中需要修改的地方有

```shell
cat example.sh

#!/bin/bash
#set -e
rand (){
  openssl rand -hex 20
}
CA_PASS=`rand | cut -c1-40`
TS_PASS=`rand | cut -c1-20`
./clean.sh
echo "CA password: $CA_PASS" >> Readme.txt
echo "Truststore password: $TS_PASS" >> Readme.txt
./gen_root_ca.sh $CA_PASS $TS_PASS

./gen_node_cert.sh 0 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 1 `rand | cut -c1-20` $CA_PASS &&  ./gen_node_cert.sh 2 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 3 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 4 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 5 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 6 `rand | cut -c1-20` $CA_PASS

#./gen_client_node_cert.sh spock `rand | cut -c1-20` $CA_PASS
./gen_client_node_cert.sh kirk `rand | cut -c1-20` $CA_PASS
./gen_client_node_cert.sh sgadmin `rand | cut -c1-20` $CA_PASS
```

脚本中一定要修改并且注意的地方,Readme.txt文件里面会保存密码

### 修改`gen_node_cert.sh`

如果配置没有问题,es起不来,可以尝试不指定IP生成密钥库,信任库

```shell
# jks文件密码写入文本
echo "$NODE_NAME keystore password :$KS_PASS" >> Readme.txt

keytool -genkey \
        -alias     $NODE_NAME \
        -keystore  $NODE_NAME-keystore.jks \
        -keyalg    RSA \
        -keysize   2048 \
        -validity  712 \
        -sigalg SHA256withRSA \
        -keypass $KS_PASS \
        -storepass $KS_PASS \
        -dname "CN=$NODE_NAME.example.com, OU=SSL, O=Test, L=Test, C=DE" \
        -ext san=dns:$NODE_NAME.example.com,dns:localhost,ip:127.0.0.1,ip:10.29.164.80,ip:10.29.164.37,oid:1.2.3.4.5.5

#oid:1.2.3.4.5.5 denote this a server node certificate for search guard

echo Generating certificate signing request for node $NODE_NAME

keytool -certreq \
        -alias      $NODE_NAME \
        -keystore   $NODE_NAME-keystore.jks \
        -file       $NODE_NAME.csr \
        -keyalg     rsa \
        -keypass $KS_PASS \
        -storepass $KS_PASS \
        -dname "CN=$NODE_NAME.example.com, OU=SSL, O=Test, L=Test, C=DE" \
        -ext san=dns:$NODE_NAME.example.com,dns:localhost,ip:127.0.0.1,ip:10.29.164.80,ip:10.29.164.37,oid:1.2.3.4.5.5

#oid:1.2.3.4.5.5 denote this a server node certificate for search guard
#一定要把与es通信的logstash和kibana，ip都包含在内，不然秘钥不能在其他ip上使用
```

### 修改脚本`gen_client_node_cert.sh`,生成sgadmin keystore password,kirk keystore password

```shell
echo "$CLIENT_NAME keystore password :$KS_PASS" >> Readme.txt
```

**执行example.sh会在当前目录生成密钥**

```shell
root@ubuntu47:~/src/search-guard-ssl/example-pki-
scripts# cat Readme.txt
CA password: b5e6350c3d1a3001621c3861a215961eb2aeaa5d
Truststore password: a49f3e3807d8c3843972
node-0 keystore password :8d21330bc20e1efedef7
node-1 keystore password :d75d4ed8a0dc91f5a8c3
node-2 keystore password :592901f5cadc97f23e40
node-3 keystore password :7ebd3dedff1a141738cb
node-4 keystore password :c36ff8e062f79ec5fb65
node-5 keystore password :f74bd73382ea407fbf69
node-6 keystore password :d255658bc42074dcd6a6
kirk keystore password :6c627ee52b047eb4fd17
sgadmin keystore password :e9688af7348f08e6d55a

下文操作
cp node-1-keystore.jks /etc/elasticsearch/
cp truststore.jks /etc/elasticsearch/
scp node-2-keystore.jks 10.29.164.37:/etc/elasticsearch/
scp truststore.jks  10.29.164.37:/etc/elasticsearch/
```

## 配置elasticsearch

 节点|ip|密钥|路径|
 ---|----|----|---|
 node-1| 10.29.164.80 | node-1-keystore.jks,truststore.jks | /etc/elasticsearch
 node-2| 10.29.164.37 | node-2-keystore.jks,truststore.jks | /etc/elasticsearch

> node-1配置示例

### 复制密钥库和信任库文件

elasticsearch用户需要读取文件权限

**jsk等文件放置到指定位置之后,注意修改文件属主,属组**

```shell
chown -R elasticsearch.elasticsearch /etc/elasticsearch
```

### node-1 配置插件

配置elasticsearch的/etc/elasticsearch/elasticsearch.yml

```shell
#################node-1-keystore.jks############################
searchguard.ssl.transport.keystore_filepath: node-1-keystore.jks
searchguard.ssl.transport.keystore_password: d75d4ed8a0dc91f5a8c3 # Readme.txt文件里面对应的密码
searchguard.ssl.transport.truststore_filepath: truststore.jks
searchguard.ssl.transport.truststore_password: a49f3e3807d8c3843972
searchguard.ssl.transport.enforce_hostname_verification: false
```

#### 配置HTTPS

```shell
searchguard.ssl.http.enabled: true
searchguard.ssl.http.keystore_filepath: node-1-keystore.jks
searchguard.ssl.http.keystore_password: d75d4ed8a0dc91f5a8c3
searchguard.ssl.http.truststore_filepath: truststore.jks
searchguard.ssl.http.truststore_password: a49f3e3807d8c3843972

#searchguard.ssl.http.clientauth_mode: REQUIRE # 开启客户端认证(仅接受来自可信客户端的HTTPS连接)
# 需要安装让es节点信任的整数,证书名称为kirk,spock,使用与节点证书相同的Root CA证书生成
searchguard.ssl.http.clientauth_mode: OPTIONAL

# 配置管理证书
searchguard.authcz.admin_dn:
 - CN=sgadmin,OU=client,O=client,L=test,C=DE

searchguard.audit.type: internal_elasticsearch

# 配置好后可重启es
/etc/init.d/elasticsearch restart
```

## 配置search guard

```shell
cd /usr/share/elasticsearch/plugins/search-guard-5/sgconfig
cp /root/kirk-keystore.jks   ./kirk-keystore.jks
cp /root/sgadmin-keystore.jks   ./sgadmin-keystore.jks
cp /root/truststore.jks   ./truststore.jks

# 执行 sgadmin.sh
cd /usr/share/elasticsearch/plugins/search-guard-5/
./tools/sgadmin.sh -cd sgconfig/ -ks sgconfig/sgadmin-keystore.jks -kspass 8a223046e542cd8af036 -ts /etc/elasticsearch/truststore.jks -tspass ee70d142789462798858 -cn my-elk-cluster

执行之后就可以看到当前集群节点数等信息
```

可以使用浏览器进入: [查询客户端身份信息](https://121.42.244.47:9200/_searchguard/sslinfo)

同样,配置node-2,node-3等等...

```shell
##############node-2-keystore.jks###################################
searchguard.ssl.transport.keystore_filepath: node-2-keystore.jks
searchguard.ssl.transport.keystore_password: 592901f5cadc97f23e40
searchguard.ssl.transport.truststore_filepath: truststore.jks
searchguard.ssl.transport.truststore_password: a49f3e3807d8c3843972
searchguard.ssl.transport.enforce_hostname_verification: false

searchguard.ssl.http.enabled: true
searchguard.ssl.http.keystore_filepath: node-2-keystore.jks
searchguard.ssl.http.keystore_password: 592901f5cadc97f23e40
searchguard.ssl.http.truststore_filepath: truststore.jks
searchguard.ssl.http.truststore_password: a49f3e3807d8c3843972

#searchguard.ssl.http.clientauth_mode: REQUIRE
searchguard.ssl.http.clientauth_mode: OPTIONAL

searchguard.authcz.admin_dn:
 - CN=sgadmin,OU=client,O=client,L=test,C=DE
# CN=sgadmin CN指定sgadmin,后面执行sgadmin.sh脚本则指定该密钥库
searchguard.audit.type: internal_elasticsearch
```

修改文件属主,属组

```shell
chown -R elasticsearch.elasticsearch /etc/elasticsearch
```

## 配置logstash

 节点|ip|密钥|路径
 ---|----|----|---
 logstash 1 | 10.29.164.80  | truststore.jks | /etc/logstash/

配置logstash的/etc/logstash/conf.d/output.conf

```shell
root@ubuntu47:/etc/logstash/conf.d# cat output.conf
output {

if [type] == "nginx-access" {
    elasticsearch {

        # 需要做如下配置,如下用户相关配置在 /usr/share/elasticsearch/plugins/search-guard-5/sgconfig# cat sg_internal_users.yml
        user => logstash
        password => logstash
        ssl => true
        ssl_certificate_verification => true
        truststore => "/etc/logstash/truststore.jks"
        truststore_password => "82df5ddf119275a190e0"

        hosts => "127.0.0.1:9200"
        index => "logstash-%{type}"
        document_type => "%{type}"
        sniffing => false
        manage_template => false
        flush_size => 20000
        idle_flush_time => 10
        template_overwrite => true
    }
}

if [type] == "nginx-access" {
    if [status] == 304 {
        zabbix {
            zabbix_server_host => "10.29.164.37"        # zabbix-server  IP
            zabbix_host => "[@metadata][zabbix_host]"   # 使用filter里面配置的
            zabbix_key => "[@metadata][zabbix_key]"     # zabbix里面配置的key,必须要配置
            zabbix_value => "status"   # 这里如果使用具体的值,可能会出现 类似这这种错误,Zabbix server at 10.29.164.37 rejected all items sent
            # status 将会取上面的 304
        }
    }
}
}
```

## 配置kibana

 节点|ip|密钥|路径
 ---|----|----|---
 kibana 1 | 10.29.164.80 | root-ca.pem | /etc/kibana/

配置kibana的/usr/share/kibana/config/kibana.yml

```shell
server.port: 5601
elasticsearch.url: "https://10.29.164.80:9200"
elasticsearch.ssl.ca: "/etc/kibana/root-ca.pem"
server.host: "0.0.0.0"
elasticsearch.username: "kibanaserver"
elasticsearch.password: "kibanaserver"
```

## 配置sgadmin限制权限

```shell
# sg 配置文件
配置文件路径 :  /usr/share/elasticsearch/plugins/search-guard-5/sgconfig/sg_roles.yml

#给kibana的权限
sg_kibana4_server:
  cluster:
      - cluster:monitor/nodes/info
      - cluster:monitor/health
      - indices:data/write/bulk*
  indices:
    '?kibana':
      '*':
        - ALL

#给logstash的权限
sg_logstash:
  cluster:
    - indices:admin/template/get
    - indices:admin/template/put
    - indices:data/write/bulk*
  indices:
    'logstash-*':
      '*':
        - CRUD
        - CREATE_INDEX
    '*beat*':
      '*':
        - CRUD
        - CREATE_INDEX

#main用户的权限
sg_readonly_main:
  cluster:
      - cluster:monitor/nodes/info
      - cluster:monitor/health
      - indices:data/read/mget*
      - indices:data/read/msearch*
  indices:
    '?kibana':
      '*':
        - ALL

#给online用户的权限
sg_readonly_online:
  cluster:
      - cluster:monitor/nodes/info
      - cluster:monitor/health
      - indices:data/read/mget*
      - indices:data/read/msearch*
  indices:
    '?kibana':
      '*':
        - ALL
```

```shell
配置文件路径: /usr/share/elasticsearch/plugins/search-guard-5/sgconfig/sg_roles_mapping.yml
#权限的对应用户
sg_readonly_main:
  users:
    - main

sg_readonly_online:
  users:
    - online

cat /usr/share/elasticsearch/plugins/search-guard-5/sgconfig/sg_internal_users.yml
#创建用户
main:
  hash: $2a$12$1WvtrH8SkxcfW0qqmU9VnutFE7giYCmtIrpbxP5SfGX7ajGsE/zy2
  #password is: DFVuxsuxnbBNzHsP8afU

online:
  hash: $2a$12$vSULu9lWyww6OqQHKYTZ5ezIrGWqmGHirr6FuLyvqRMQaDikUWw/i
  #password is: AHVbLWzFwohb9CLLARio

#如何创建用户
cd /usr/share/elasticsearch/plugins/search-guard-5/tools
bash hash.sh -p '密码'
```

## 执行sgtool

```shell
cd /usr/share/elasticsearch/plugins/search-guard-5/
./tools/sgadmin.sh -cd sgconfig/ -ks sgconfig/sgadmin-keystore.jks -kspass 8a223046e542cd8af036 -ts /etc/elasticsearch/truststore.jks -tspass ee70d142789462798858 -cn my-elk-cluster

root@ubuntu47:/usr/share/elasticsearch/plugins/search-guard-5# . ./tools/sgadmin.sh -cd sgconfig/ -ks sgconfig/sgadmin-keystore.jks -kspass 6a278d4484b52dc03dbbfe67fd6c1cdab4d31f46 -ts /etc/elasticsearch/truststore.jks -tspass 9ed1ea485a7e906acb5c -cn my-elk-cluster

```

注意:每次重启es的时候都需要执行sg重新给权限,只是添加用户和加权不影响集群

可将如下命令写到脚本,方便执行

```shell
root@ubuntu47:/usr/share/elasticsearch/plugins/search-guard-5# . ./tools/sgadmin.sh -cd sgconfig/ -ks sgconfig/sgadmin-keystore.jks -kspass e9688af7348f08e6d55a -ts /etc/elasticsearch/truststore.jks -tspass a49f3e3807d8c3843972 -cn my-elk-cluster
```
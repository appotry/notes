# Elastic Stack安装

## 本文环境

```shell
root@ubuntu75:~# lsb_release -a
LSB Version:    core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.1 LTS
Release:        16.04
Codename:       xenial
```

## 安装Java环境

两种方式

[jdk8 下载地址](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

```shell
oracle下载jdk需要认证，所以直接到官网下载,或者使用如下方法下载,注意版本

root@ubuntu75:~/src# pwd
/root/src
root@ubuntu75:~/src# wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz

tar xf jdk-8u101-linux-x64.tar.gz
mv jdk1.8.0_101/ /opt/
ln -s /opt/jdk1.8.0_101/ /opt/jdk

配置环境变量 vim /etc/profile

    export JAVA_HOME=/opt/jdk
    export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH
    export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
    或使用命令：sed -i.ori '$a export JAVA_HOME=/opt/jdk\nexport PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH\nexport CLASSPATH=.$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar' /etc/profile

. /etc/profile

运行java -version命令，能查到java版本，则安装成功
```

## 安装Elastic Stack

> 针对Ubuntu，推荐全部使用deb包进行安装

### 使用deb包安装

```shell
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.2.deb &
sha1sum elasticsearch-5.1.2.deb
sudo dpkg -i elasticsearch-5.1.2.deb

wget -q https://artifacts.elastic.co/downloads/logstash/logstash-5.1.2.deb &
dpkg -i logstash-5.1.2.deb

wget -q https://artifacts.elastic.co/downloads/kibana/kibana-5.1.2-amd64.deb &
sha1sum kibana-5.1.2-amd64.deb
sudo dpkg -i kibana-5.1.2-amd64.deb
```

参考链接

[Elastic Stack and Product Documentation](https://www.elastic.co/guide/index.html)

[elastic](https://www.elastic.co/guide/en/kibana/current/deb.html)

[kibana](https://www.elastic.co/guide/en/kibana/current/deb.html)

### 使用仓库安装

```shell
## 安装elasticsearch

sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update && sudo apt-get install elasticsearch

配置文件路径：
    /etc/elasticsearch/elasticsearch.yml
    /etc/elasticsearch/logging.yml

启动方法：
root@ubuntu75:~# ps -p 1
  PID TTY          TIME CMD
    1 ?        00:00:02 systemd

    sudo /bin/systemctl daemon-reload
    sudo /bin/systemctl enable elasticsearch.service

    sudo systemctl start elasticsearch.service
    sudo systemctl stop elasticsearch.service

## 安装logstash

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
cat >> /etc/apt/sources.list <<EOF
deb http://packages.elasticsearch.org/logstash/5.0/debian stable main
EOF
apt-get update
apt-get install logstash
```

### Running Logstash on Docker

[Running Logstash on Docker](https://www.elastic.co/guide/en/logstash/current/docker.html)

## 报错

```shell
安装时报如下错误：

    Selecting previously unselected package logstash.
    (Reading database ... 101074 files and directories currently installed.)
    Preparing to unpack logstash-5.1.2.deb ...
    Unpacking logstash (1:5.1.2-1) ...
    Setting up logstash (1:5.1.2-1) ...
    Using provided startup.options file: /etc/logstash/startup.options
    /usr/share/logstash/vendor/jruby/bin/jruby: line 388: /usr/bin/java: No such file or directory
    Unable to install system startup script for Logstash.

解决
root@ubuntu75:~/src# ln -s /opt/jdk/bin/java /usr/bin/java
root@ubuntu75:~/src# ln -s /opt/jdk/bin/javac /usr/bin/javac
```
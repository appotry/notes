# 1. logstash-output-zabbix

## 1.1. Table of content

<!-- TOC -->

- [1. logstash-output-zabbix](#1-logstash-output-zabbix)
    - [1.1. Table of content](#11-table-of-content)
    - [1.2. 安装](#12-安装)
        - [1.2.1. 本地安装](#121-本地安装)
        - [1.2.2. 在线安装](#122-在线安装)
    - [1.3. 由于网络原因,使用下面方式安装](#13-由于网络原因使用下面方式安装)
        - [1.3.1. Gemfile](#131-gemfile)
        - [1.3.2. 修改logstash/Gemfile.jruby-1.9.lock](#132-修改logstashgemfilejruby-19lock)
        - [1.3.3. 新加文件(注意文件属主,属组 logstash)](#133-新加文件注意文件属主属组-logstash)
        - [1.3.4. 检查zabbix插件是否安装成功](#134-检查zabbix插件是否安装成功)
    - [1.4. logstash向zabbix发送数据](#14-logstash向zabbix发送数据)
        - [1.4.1. 安装logstash-output-zabbix3](#141-安装logstash-output-zabbix3)
        - [1.4.2. zabbix Web界面配置](#142-zabbix-web界面配置)
        - [1.4.3. 配置filter](#143-配置filter)
        - [1.4.4. 配置output](#144-配置output)
        - [1.4.5. 问题记录](#145-问题记录)
            - [1.4.5.1. [WARN ][logstash.outputs.zabbix  ] Field referenced by 1 is missing](#1451-warn-logstashoutputszabbix---field-referenced-by-1-is-missing)
            - [1.4.5.2. [WARN ][logstash.outputs.zabbix  ] Zabbix server at 10.29.164.37 rejected all items sent. {:zabbix_host=>"ubuntu47"}](#1452-warn-logstashoutputszabbix---zabbix-server-at-102916437-rejected-all-items-sent-zabbix_hostubuntu47)

<!-- /TOC -->

## 1.2. 安装

### 1.2.1. 本地安装

[logstash-plugins](https://github.com/logstash-plugins/logstash-output-zabbix)

### 1.2.2. 在线安装

    bin/logstash-plugin install logstash-output-zabbix

## 1.3. 由于网络原因,使用下面方式安装

美国开通ecs,使用在线安装,对比差异,提取出以下安装方式

操作之前备份logstash目录

[Back to TOC](#11-table-of-content)

### 1.3.1. Gemfile

```shell
    root@ubuntu47:~/test-logstash-output-zabbix/chayi# echo 'gem "logstash-output-zabbix"' >> /usr/share/logstash/Gemfile
    root@ubuntu47:/usr/share/logstash# tail -2 Gemfile
    gem "logstash-output-zabbix"
```

### 1.3.2. 修改logstash/Gemfile.jruby-1.9.lock

```shell
    /usr/share/logstash/Gemfile.jruby-1.9.lock


    488    logstash-output-zabbix (3.0.1)
    489      logstash-codec-plain
    490      logstash-core-plugin-api (>= 1.60, <= 2.99)
    491      zabbix_protocol (>= 0.1.5)


    610    zabbix_protocol (0.1.5)
    611      multi_json

    718  logstash-output-zabbix
```

### 1.3.3. 新加文件(注意文件属主,属组 logstash)

相关文件已经打包在项目里,文件名add-logstash-output-zabbix.tar.gz

vendor/bundle/jruby/1.9/cache

```shell

    root@ubuntu47:~/test-logstash-output-zabbix/logstash# ls vendor/bundle/jruby/1.9/cache
    logstash-output-zabbix-3.0.1.gem  zabbix_protocol-0.1.5.gem
```

vendor/bundle/jruby/1.9/gems/zabbix_protocol-0.1.5  目录下所有文件

```shell
    root@ubuntu47:~/test-logstash-output-zabbix/logstash# ls vendor/bundle/jruby/1.9/gems/zabbix_protocol-0.1.5
    Gemfile  LICENSE.txt  README.md  Rakefile  lib  spec  zabbix_protocol.gemspec
```

vendor/bundle/jruby/1.9/gems/logstash-output-zabbix-3.0.1  目录下所有文件

vendor/bundle/jruby/1.9/specifications/logstash-output-zabbix-3.0.1.gemspec

vendor/bundle/jruby/1.9/specifications/zabbix_protocol-0.1.5.gemspec

### 1.3.4. 检查zabbix插件是否安装成功

上述操作完成之后,需要重启logstash,而后通过如下命令验证

```shell
root@ubuntu47:/usr/share/logstash# bin/logstash-plugin list|grep zabbix
logstash-output-zabbix
```

## 1.4. logstash向zabbix发送数据

### 1.4.1. 安装logstash-output-zabbix3

[Back to TOC](#11-table-of-content)

### 1.4.2. zabbix Web界面配置

![logstash-output-zabbix-1](http://oi480zo5x.bkt.clouddn.com/logstash-output-zabbix-1.jpg)

### 1.4.3. 配置filter

```shell
root@ubuntu47:/etc/logstash/conf.d# cat filter.conf
filter {
    if [type] == "nginx-access" {
        json {
            source => "message"
            remove_field => [ "Arg0","Arg1","Arg2","Arg3","Arg4","Arg5","Arg6","Arg7","Arg8","Arg3","Arg9","Arg10" ]
    }

        mutate {
            split => [ "upstreamtime", "," ]
        }
        mutate {
            convert => [ "upstreamtime", "float" ]
    }
        if [status] == 304 {
            mutate {
                add_field => { "[@metadata][zabbix_key]" => "nginx_status" }   # 同zabbix Web里配置的监控项里对应的key 一致
                add_field => { "[@metadata][zabbix_host]" => "ubuntu47" }      # zabbix 配置的当前服务器的 Host name 一致
                # add_field => { "[nginx_status]" => "字符串用双引号一起来,数字不需要引号" }      # 如果有这种需求,可以添加一个field,定义为想要的数据,然后写到zabbix(output里面的配置,zabbix_value => "nginx_status")
            }
        }
    }
}
```

[Back to TOC](#11-table-of-content)

### 1.4.4. 配置output

```shell
root@ubuntu47:/etc/logstash/conf.d# cat output.conf
output {

if [type] == "nginx-access" {
    elasticsearch {
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
            zabbix_key => "[@metadata][zabbix_key]"     # filter里面配置的key,必须要配置
            zabbix_value => "status"   # 这里如果使用具体的值,可能会出现 类似这这种错误,Zabbix server at 10.29.164.37 rejected all items sent
            # status 将会取上面的 304
        }
    }
}
}
```

[Back to TOC](#11-table-of-content)

### 1.4.5. 问题记录

#### 1.4.5.1. [WARN ][logstash.outputs.zabbix  ] Field referenced by 1 is missing

```shell
将漏掉的 Field 添加到filter中
比如 filter中添加如下配置
            mutate {
                add_field => { "[@metadata][zabbix_key]" => "nginx_status" }
                add_field => { "[@metadata][zabbix_host]" => "ubuntu47" }
          }
```

#### 1.4.5.2. [WARN ][logstash.outputs.zabbix  ] Zabbix server at 10.29.164.37 rejected all items sent. {:zabbix_host=>"ubuntu47"}

```shell
原因: zabbix_value => "1"

修改成如下配置后,解决:
    zabbix_value => "status"
```

[Back to TOC](#11-table-of-content)
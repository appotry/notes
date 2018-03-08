# logstash

## 配置

### logstash 内存大小配置

root@ubuntu47:/etc/logstash# vim jvm.options

```shell
# 具体根据服务器硬件配置

-Xms256m
-Xmx256m
```

### logstash.yml配置

```shell
root@ubuntu47:/etc/logstash# grep -Ev "^$|#" logstash.yml
path.data: /var/lib/logstash
path.config: /etc/logstash/conf.d
path.logs: /var/log/logstash
```

### filter.conf

以收集Nginx日志为例,需要先配置Nginx生成的日志格式为json格式(具体设置参考Nginx文档).

```shell
root@ubuntu47:/etc/logstash/conf.d# cat 1
cat filter.conf

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

        #if [status] == 304 {
        #    mutate {
        #        add_field => { "[@metadata][zabbix_key]" => "nginx_status" }
        #        add_field => { "[@metadata][zabbix_host]" => "ubuntu47" }
        #  }
        #}
# output-zabbix 插件配置
if [type] == "nginx-access" {
        if [request_method] == "GET" {
            mutate {
                add_field => { "[@metadata][zabbix_key]" => "nginx_request_method" }
                add_field => { "[@metadata][zabbix_host]" => "ubuntu47" }
          }
        }

}
}
}
```

### input.conf

cat input.conf

```shell

input {
 beats {
   port => 5044
  }
}
```

### output.conf

cat output.conf

```shell
output {

if [type] == "nginx-access" {
  elasticsearch {
    user => logstash
    password => logstash
    # search guard相关配置
    # ssl => true
    # ssl_certificate_verification => true
    # truststore => "/etc/logstash/truststore.jks"
    # truststore_password => "82df5ddf119275a190e0"
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

#if [type] == "nginx-access" {
#   if [status] == 304 {
#   zabbix {
#         zabbix_server_host => "10.29.164.37"
#         zabbix_host => "[@metadata][zabbix_host]"
#         zabbix_key => "[@metadata][zabbix_key]"
#         zabbix_value => "status"
#     }
#}
#}

# output-zabbix 插件配置
    if [type] == "nginx-access" {
        if [request_method] == "GET" {
            zabbix {
                zabbix_server_host => "10.29.164.37"
                zabbix_host => "[@metadata][zabbix_host]"
                zabbix_key => "[@metadata][zabbix_key]"
                zabbix_value => "request_method"
            }
        }
    }

}
```

## logstash启动文件

使用logstash启动文件  进行启动即可
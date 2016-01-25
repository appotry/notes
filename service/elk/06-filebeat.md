<!-- TOC -->

- [1. filebeat](#1-filebeat)
    - [1.1. 安装](#11-安装)
    - [1.2. 使用filebeat](#12-使用filebeat)
    - [1.3. filebeat配置](#13-filebeat配置)
    - [1.4. 参考配置](#14-参考配置)
    - [1.5. 注释](#15-注释)

<!-- /TOC -->

# 1. filebeat

> Filebeat is a log data shipper. Installed as an agent on your servers, Filebeat monitors the log directories or specific log files, tails the files, and forwards them either to Elasticsearch or Logstash for indexing.

Filebeat 用来做数据转发，作为代理安装在服务器上，Filebeat监控日志目录，或者指定日志文件，

## 1.1. 安装

[downloads](https://www.elastic.co/downloads)

```shell
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.2.0-amd64.deb

sudo dpkg -i filebeat-5.2.0-amd64.deb
```

## 1.2. 使用filebeat

```shell
root@ubuntu75:/etc/filebeat# /usr/bin/filebeat.sh -configtest -e .
2017/02/06 03:54:11.053687 beat.go:267: INFO Home path: [/usr/share/filebeat] Config path: [/etc/filebeat] Data path: [/var/lib/filebeat] Logs path: [/var/log/filebeat]
2017/02/06 03:54:11.053893 beat.go:177: INFO Setup Beat: filebeat; Version: 5.2.0
2017/02/06 03:54:11.053863 logp.go:219: INFO Metrics logging every 30s
2017/02/06 03:54:11.054148 output.go:167: INFO Loading template enabled. Reading template file: /etc/filebeat/filebeat.template.json
2017/02/06 03:54:11.054478 output.go:178: INFO Loading template enabled for Elasticsearch 2.x. Reading template file: /etc/filebeat/filebeat.template-es2x.json
2017/02/06 03:54:11.054735 client.go:120: INFO Elasticsearch url: http://localhost:9200
2017/02/06 03:54:11.054824 outputs.go:106: INFO Activated elasticsearch as output plugin.
2017/02/06 03:54:11.054947 publish.go:291: INFO Publisher name: ubuntu75
2017/02/06 03:54:11.055179 async.go:63: INFO Flush Interval set to: 1s
2017/02/06 03:54:11.055237 async.go:64: INFO Max Bulk Size set to: 50
Config OK
```

## 1.3. filebeat配置

```shell
root@ubuntu75:/etc/filebeat# cat filebeat.yml
filebeat.prospectors:
- input_type: log
  paths:
    - /var/log/nginx/access.log
  document_type: nginx-access
output.logstash:
  hosts: ["localhost:5044"]
shipper:
logging:
```

## 1.4. 参考配置

```yaml
filebeat:
  spool_size: 1024
  idle_timeout: "5s"
  registry_file: ".filebeat"
  config_dir: "path/to/configs/contains/many/yaml"
  prospectors:
    -
      fields:
        ownfield: "mac"
      paths:
        - /var/log/system.log
        - /var/log/wifi.log
      include_lines: ["^ERR", "^WARN"]
      exclude_lines: ["^OK"]
    -
      document_type: "apache"
      ignore_older: "24h"
      scan_frequency: "10s"
      tail_files: false
      harvester_buffer_size: 16384
      backoff: "1s"
      paths:
        - "/var/log/apache/*"
      exclude_files: ["/var/log/apache/error.log"]
    -
      input_type: "stdin"
      multiline:
        pattern: '^[[:space:]]'
        negate: false
        match: after
output.logstash:
  hosts: ["localhost:5044"]
```

## 1.5. 注释

```shell
filebeat:
    spool_size: 1024                                    # 最大可以攒够 1024 条数据一起发送出去
    idle_timeout: "5s"                                  # 否则每 5 秒钟也得发送一次
    registry_file: ".filebeat"                          # 文件读取位置记录文件，会放在当前工作目录下。所以如果你换一个工作目录执行 filebeat 会导致重复传输！
    config_dir: "path/to/configs/contains/many/yaml"    # 如果配置过长，可以通过目录加载方式拆分配置
    prospectors:                                        # 有相同配置参数的可以归类为一个 prospector
        -
            fields:
                ownfield: "mac"                         # 类似 logstash 的 add_fields
            paths:
                - /var/log/system.log                   # 指明读取文件的位置
                - /var/log/wifi.log
            include_lines: ["^ERR", "^WARN"]            # 只发送包含这些字样的日志
            exclude_lines: ["^OK"]                      # 不发送包含这些字样的日志
        -
            document_type: "apache"                     # 定义写入 ES 时的 _type 值
            ignore_older: "24h"                         # 超过 24 小时没更新内容的文件不再监听。在 windows 上另外有一个配置叫 force_close_files，只要文件名一变化立刻关闭文件句柄，保证文件可以被删除，缺陷是可能会有日志还没读完
            scan_frequency: "10s"                       # 每 10 秒钟扫描一次目录，更新通配符匹配上的文件列表
            tail_files: false                           # 是否从文件末尾开始读取
            harvester_buffer_size: 16384                # 实际读取文件时，每次读取 16384 字节
            backoff: "1s"                               # 每 1 秒检测一次文件是否有新的一行内容需要读取
            paths:
                - "/var/log/apache/*"                   # 可以使用通配符
            exclude_files: ["/var/log/apache/error.log"]
        -
            input_type: "stdin"                         # 除了 "log"，还有 "stdin"
            multiline:                                  # 多行合并
                pattern: '^[[:space:]]'
                negate: false
                match: after
output.logstash:
  # The Logstash hosts
  hosts: ["localhost:5044"]
```
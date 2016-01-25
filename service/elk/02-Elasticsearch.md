<!-- TOC -->

- [1. elasticsearch](#1-elasticsearch)
    - [1.1. 配置文件](#11-配置文件)
        - [1.1.1. 修改elasticsearch内存](#111-修改elasticsearch内存)
    - [1.2. 启动](#12-启动)
    - [1.3. elasticsearch-head](#13-elasticsearch-head)
    - [1.4. 使用curl命令操作elasticsearch](#14-使用curl命令操作elasticsearch)
        - [1.4.1. _cat系列](#141-_cat系列)
        - [1.4.2. 第二：_cluster系列](#142-第二_cluster系列)
        - [1.4.3. 第三：_nodes系列](#143-第三_nodes系列)
        - [1.4.4. 第四：索引操作](#144-第四索引操作)
    - [1.5. 报错信息](#15-报错信息)
        - [1.5.1. elasticsearch-head安装报错](#151-elasticsearch-head安装报错)
        - [1.5.2. elasticsearch启动报错](#152-elasticsearch启动报错)
        - [1.5.3. 启动elasticsearch报错](#153-启动elasticsearch报错)
        - [1.5.4. 启动elasticsearch报错2](#154-启动elasticsearch报错2)

<!-- /TOC -->

# 1. elasticsearch

## 1.1. 配置文件

```shell
cat >>/etc/elasticsearch/elasticsearch.yml<<EOF
cluster.name: elk-cluster
node.name: node-1
path.data: /data/es-data
path.log: /data/es-data
network.host: 0.0.0.0
http.port: 9200
discovery.zen.ping.unicast.hosts: ["10.174.217.111","10.174.214.247"]
discovery.zen.minimum_master_nodes: 1
EOF

避免脑裂现象，用到的一个参数是：discovery.zen.minimum_master_nodes。这个参数决定了要选举一个Master需要多少个节点（最少候选节点数）。默认值是1。根据一般经验这个一般设置成 N/2 + 1，N是集群中节点的数量，例如一个有3个节点的集群，minimum_master_nodes 应该被设置成 3/2 + 1 = 2（向下取整）。
用到的另外一个参数是：discovery.zen.ping.timeout，等待ping响应的超时时间，默认值是3秒。如果网络缓慢或拥塞，建议略微调大这个值。这个参数不仅仅适应更高的网络延迟，也适用于在一个由于超负荷而响应缓慢的节点的情况。
如果您刚开始使用elasticsearch，建议搭建拥有3个节点的集群，这种方式可以把discovery.zen.minimum_master_nodes设置成2，这样就限制了发生脑裂现象的可能，且保持着高度的可用性：如果你设置了副本，在丢失一个节点的情况下，集群仍可运行

```

### 1.1.1. 修改elasticsearch内存

```shell
/etc/elasticsearch/jvm.options

-Xms2g
-Xmx2g
```

## 1.2. 启动

Running Elasticsearch with SysV initedit

```shell
Use the update-rc.d command to configure Elasticsearch to start automatically when the system boots up:

sudo update-rc.d elasticsearch defaults 95 10
Elasticsearch can be started and stopped using the service command:

sudo -i service elasticsearch start
sudo -i service elasticsearch stop
If Elasticsearch fails to start for any reason, it will print the reason for failure to STDOUT. Log files can be found in /var/log/elasticsearch/.
```

Running Elasticsearch with systemdedit

```shell
To configure Elasticsearch to start automatically when the system boots up, run the following commands:

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

Elasticsearch can be started and stopped as follows:

sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
```

## 1.3. elasticsearch-head

[A web front end for an Elasticsearch cluster](https://github.com/mobz/elasticsearch-head)

[参考链接](http://www.cnblogs.com/xing901022/p/6030296.html)

```shell
Running as a plugin of Elasticsearch

Install elasticsearch-head:
– for Elasticsearch 5.x:
site plugins are not supported. Run elasticsearch-head as a standalone server

先决条件
    1. git
    2. node
    3. grunt-cli
    4. phantomjs

安装步骤
    1. npm install -g cnpm --registry=https://registry.npm.taobao.org
    2. cnpm install -g grunt-cli
    3. git clone git://github.com/mobz/elasticsearch-head.git
    4. cd elasticsearch-head
    5. cnpm install
    6. grunt server

使用screen一直运行，安全问题如何解决？
```


## 1.4. 使用curl命令操作elasticsearch

### 1.4.1. _cat系列

```shell
_cat系列提供了一系列查询elasticsearch集群状态的接口。你可以通过执行
curl -XGET localhost:9200/_cat
获取所有_cat系列的操作
=^.^=
/_cat/allocation
/_cat/shards
/_cat/shards/{index}
/_cat/master
/_cat/nodes
/_cat/indices
/_cat/indices/{index}
/_cat/segments
/_cat/segments/{index}
/_cat/count
/_cat/count/{index}
/_cat/recovery
/_cat/recovery/{index}
/_cat/health
/_cat/pending_tasks
/_cat/aliases
/_cat/aliases/{alias}
/_cat/thread_pool
/_cat/plugins
/_cat/fielddata
/_cat/fielddata/{fields}
你也可以后面加一个v，让输出内容表格显示表头，举例

name       component        version type url
Prometheus analysis-mmseg   NA      j
Prometheus analysis-pinyin  NA      j
Prometheus analysis-ik      NA      j
Prometheus analysis-ik      NA      j
Prometheus analysis-smartcn 2.1.0   j
Prometheus segmentspy       NA      s    /_plugin/segmentspy/
Prometheus head             NA      s    /_plugin/head/
Prometheus bigdesk          NA      s    /_plugin/bigdesk/
Xandu      analysis-ik      NA      j
Xandu      analysis-pinyin  NA      j
Xandu      analysis-mmseg   NA      j
Xandu      analysis-smartcn 2.1.0   j
Xandu      head             NA      s    /_plugin/head/
Xandu      bigdesk          NA      s    /_plugin/bigdesk/
Onyxx      analysis-ik      NA      j
Onyxx      analysis-mmseg   NA      j
Onyxx      analysis-smartcn 2.1.0   j
Onyxx      analysis-pinyin  NA      j
Onyxx      head             NA      s    /_plugin/head/
Onyxx      bigdesk          NA      s    /_plugin/bigdesk/
```

### 1.4.2. 第二：_cluster系列

```shell
1. 查询设置集群状态
    curl -XGET localhost:9200/_cluster/health?pretty=true
    pretty=true   表示格式化输出
    level=indices 表示显示索引状态
    level=shards  表示显示分片信息
2. 显示集群系统信息，包括CPU JVM等等
    curl -XGET localhost:9200/_cluster/stats?pretty=true
3. 集群的详细信息。包括节点、分片等。
    curl -XGET localhost:9200/_cluster/state?pretty=true

4. 获取集群堆积的任务
    curl -XGET localhost:9200/_cluster/pending_tasks?pretty=true

3、修改集群配置
    举例：
    curl -XPUT localhost:9200/_cluster/settings -d '{
        "persistent" : {
            "discovery.zen.minimum_master_nodes" : 2
        }
    }'
    transient 表示临时的，persistent表示永久的

4、curl -XPOST ‘localhost:9200/_cluster/reroute’ -d ‘xxxxxx’
    对shard的手动控制，参考http://zhaoyanblog.com/archives/687.html
5、关闭节点
    关闭指定192.168.1.1节点
    curl -XPOST ‘http://192.168.1.1:9200/_cluster/nodes/_local/_shutdown’
    curl -XPOST ‘http://localhost:9200/_cluster/nodes/192.168.1.1/_shutdown’
    关闭主节点
    curl -XPOST ‘http://localhost:9200/_cluster/nodes/_master/_shutdown’
    关闭整个集群
    $ curl -XPOST ‘http://localhost:9200/_shutdown?delay=10s’
    $ curl -XPOST ‘http://localhost:9200/_cluster/nodes/_shutdown’
    $ curl -XPOST ‘http://localhost:9200/_cluster/nodes/_all/_shutdown’
    delay=10s表示延迟10秒关闭
```

### 1.4.3. 第三：_nodes系列

```shell
1、查询节点的状态
    curl -XGET ‘http://localhost:9200/_nodes/stats?pretty=true’
    curl -XGET ‘http://localhost:9200/_nodes/192.168.1.2/stats?pretty=true’
    curl -XGET ‘http://localhost:9200/_nodes/process’
    curl -XGET ‘http://localhost:9200/_nodes/_all/process’
    curl -XGET ‘http://localhost:9200/_nodes/192.168.1.2,192.168.1.3/jvm,process’
    curl -XGET ‘http://localhost:9200/_nodes/192.168.1.2,192.168.1.3/info/jvm,process’
    curl -XGET ‘http://localhost:9200/_nodes/192.168.1.2,192.168.1.3/_all
    curl -XGET ‘http://localhost:9200/_nodes/hot_threads
```

### 1.4.4. 第四：索引操作

```shell
1、获取索引
    curl -XGET ‘http://localhost:9200/{index}/{type}/{id}’
2、索引数据
    curl -XPOST ‘http://localhost:9200/{index}/{type}/{id}’ -d'{“a”:”avalue”,”b”:”bvalue”}’
3、删除索引
    curl -XDELETE ‘http://localhost:9200/{index}/{type}/{id}’
4、设置mapping
    curl -XPUT http://localhost:9200/{index}/{type}/_mapping -d '{
    "{type}" : {
        "properties" : {
        "date" : {
            "type" : "long"
        },
        "name" : {
            "type" : "string",
            "index" : "not_analyzed"
        },
        "status" : {
            "type" : "integer"
        },
        "type" : {
            "type" : "integer"
        }
        }
    }
    }'

5、获取mapping
    curl -XGET http://localhost:9200/{index}/{type}/_mapping
6、搜索
    curl -XGET 'http://localhost:9200/{index}/{type}/_search' -d '{
        "query" : {
            "term" : { "user" : "kimchy" } //查所有 "match_all": {}
        },
        "sort" : [{ "age" : {"order" : "asc"}},{ "name" : "desc" } ],
        "from":0,
        "size":100
    }
    curl -XGET 'http://localhost:9200/{index}/{type}/_search' -d '{
        "filter": {"and":{"filters":[{"term":{"age":"123"}},{"term":{"name":"张三"}}]},
        "sort" : [{ "age" : {"order" : "asc"}},{ "name" : "desc" } ],
        "from":0,
        "size":100
    }
```

## 1.5. 报错信息

### 1.5.1. elasticsearch-head安装报错

```shell
npm ERR! Failed at the phantomjs-prebuilt@2.1.14 install script 'node install.js'.
npm ERR! Make sure you have the latest version of node.js and npm installed.
npm ERR! If you do, this is most likely a problem with the phantomjs-prebuilt package,

如果报以上错误，可能是因为网络问题，可以使用淘宝NPM镜像
```

### 1.5.2. elasticsearch启动报错

```shell
[2017-02-15T14:02:19,113][INFO ][o.e.n.Node               ] [node-1] starting ...
[2017-02-15T14:02:19,415][INFO ][o.e.t.TransportService   ] [node-1] publish_address {121.42.244.47:9300}, bound_addresses {0.0.0.0:9300}
[2017-02-15T14:02:19,420][INFO ][o.e.b.BootstrapCheck     ] [node-1] bound or publishing to a non-loopback or non-link-local address, enforcing bootstrap checks
[2017-02-15T14:02:19,431][ERROR][o.e.b.Bootstrap          ] [node-1] node validation exception
bootstrap checks failed
max virtual memory areas vm.max_map_count [65530] likely too low, increase to at least [262144]
[2017-02-15T14:02:19,441][INFO ][o.e.n.Node               ] [node-1] stopping ...
[2017-02-15T14:02:19,536][INFO ][o.e.n.Node               ] [node-1] stopped
[2017-02-15T14:02:19,536][INFO ][o.e.n.Node               ] [node-1] closing ...
[2017-02-15T14:02:19,558][INFO ][o.e.n.Node               ] [node-1] closed
```

是因为操作系统的vm.max_map_count参数设置太小导致的，执行以下命令：

    sysctl -w vm.max_map_count=655360

并用以下命令查看是否修改成功

    sysctl -a | grep "vm.max_map_count"

如果能正常输出655360，则说明修改成功，然后再次启动elasticsearch

把配置好的安装包拷贝一份到其他两台机器上，修改 config/elasticsearch.yml下的node.name和network.host为对于的机器即可。

```shell
sysctl -w vm.max_map_count=655360
    结果:vm.max_map_count = 655360
```


### 1.5.3. 启动elasticsearch报错

情况:Ubuntu查看日志

```shell
执行
    systemctl start elasticsearch.service
检查端口不存在,没有生成日志文件
    ls /var/log/elasticsearch/查看无内容
查看系统日志

tailf /var/log/syslog
Feb 15 15:30:58 iZm5e7si86xwstzpneime7Z systemd[1]: Started Elasticsearch.
Feb 15 15:30:58 iZm5e7si86xwstzpneime7Z elasticsearch[10379]: Could not find any executable java binary. Please install java in your PATH or set JAVA_HOME
Feb 15 15:30:58 iZm5e7si86xwstzpneime7Z systemd[1]: elasticsearch.service: Main process exited, code=exited, status=1/FAILURE
Feb 15 15:30:58 iZm5e7si86xwstzpneime7Z systemd[1]: elasticsearch.service: Unit entered failed state.
Feb 15 15:30:58 iZm5e7si86xwstzpneime7Z systemd[1]: elasticsearch.service: Failed with result 'exit-code'.

提示java不存在
```

已经安装java,java -version能显示版本,此时注意查看/usr/bin/java是否存在
解决办法,创建软连接

```shell
root@ubuntu66:~# ln -s /opt/jdk/bin/java /usr/bin/java
root@ubuntu66:~# ln -s /opt/jdk/bin/javac /usr/bin/javac
```

### 1.5.4. 启动elasticsearch报错2

```shell
Feb 15 16:28:16 iZm5e7si86xwstzpneime7Z elasticsearch[11697]: Exception in thread "main" SettingsException[Failed to load settings from /etc/elasticsearch/elasticsearch.yml]; nested: AccessDeniedException[/etc/elasticsearch/elasticsearch.yml];
```

权限问题,解决办法

注意Elastic Stack对应成员的配置文件属主,归属组均要给对应成员

```shell
root@ubuntu66:/etc/elasticsearch# ls -l
total 20
-rwxr-x--- 1 root root          3153 Feb 15 15:03 elasticsearch.yml
-rwxr-x--- 1 root root          3160 Feb 15 14:10 elasticsearch.yml.bak
-rwxr-x--- 1 root elasticsearch 2668 Feb 15 14:08 jvm.options
-rwxr-x--- 1 root elasticsearch 3988 Oct 26 12:40 log4j2.properties
drwxr-x--- 2 root elasticsearch 4096 Oct 26 12:40 scripts
root@ubuntu66:/etc/elasticsearch# chown root.elasticsearch elasticsearch.yml
root@ubuntu66:/etc/elasticsearch# chown root.elasticsearch elasticsearch.yml.bak
```
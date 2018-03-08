# Elastic Stack

ELK Stack的新名字

## Elasticsearch

Elasticsearch是个开源分布式搜索引擎，它的特点有：分布式，零配置，自动发现，索引自动分片，索引副本机制，restful风格接口，多数据源，自动搜索负载等。

## Logstash

Logstash是一个开源的用于收集,分析和存储日志的工具。

## Kibana

Kibana 也是一个开源和免费的工具，Kibana可以为 Logstash 和 ElasticSearch 提供的日志分析友好的 Web 界面，可以汇总、分析和搜索重要数据日志。

## Beats

Beats是elasticsearch公司开源的一款采集系统监控数据的代理agent，是在被监控服务器上以客户端形式运行的数据收集器的统称，可以直接把数据发送给Elasticsearch或者通过Logstash发送给Elasticsearch，然后进行后续的数据分析活动。

**Beats 作为日志搜集器没有Logstash 作为日志搜集器消耗资源，解决了 Logstash 在各服务器节点上占用系统资源高的问题。**

Beats由如下组成

### Packetbeat

一个网络数据包分析器，用于监控、收集网络流量信息，

Packetbeat嗅探服务器之间的流量，解析应用层协议，并关联到消息的处理，其支持 ICMP (v4 and v6)、DNS、HTTP、Mysql、PostgreSQL、Redis、

MongoDB、Memcache等协议；

### Filebeat

用于监控、收集服务器日志文件，其已取代 logstash forwarder；

### Metricbeat

可定期获取外部系统的监控指标信息，其可以监控、收集Apache、HAProxy、MongoDB、MySQL、Nginx、PostgreSQL、Redis、System、Zookeeper等服务；

### Winlogbeat：用于监控、收集Windows系统的日志信息；

### Create your own Beat

自定义beat ，如果上面的指标不能满足需求，elasticsarch鼓励开发者使用go语言，扩展实现自定义的beats，只需要按照模板，实现监控的输入，日志，输出等即可。

## X-Pack

x-pack是elasticsearch的一个扩展包，将安全，警告，监视，图形，报告和机器学习功能捆绑在一个易于安装的软件包中，虽然x-pack被设计为一个无缝的工作，但是你可以轻松的启用或者关闭一些功能.

## 参考推荐

- [三斗室 http://chenlinux.com/](http://chenlinux.com/)
- [elk-stack-guide-cn](https://github.com/chenryn/ELKstack-guide-cn), 书籍如果失效, 可以去作者github找
- [elk-stack-guide-cn 作者github](https://github.com/chenryn)

# Kibana

## 配置文件

```shell
root@ubuntu75:/etc/nginx/conf.d# tail -3 /etc/kibana/kibana.yml
server.host: "0.0.0.0"
elasticsearch.url: "http://127.0.0.1:9200"

# 使用search guard会有额外的配置:

elasticsearch.ssl.ca: "/etc/kibana/root-ca.pem"
elasticsearch.username: "kibanaserver"
# 密码请自行修改
elasticsearch.password: "xxx"
elasticsearch.ssl.verify: true
```

## 启动kibana

```shell
systemctl start kibana.service

tcp    LISTEN     0      128       *:5601                  *:*                   users:(("node",pid=28924,fd=11))
kibana 默认监听5601端口
```

## 问题解决

> kibana Unable to connect to Elasticsearch at https://127.0.0.1:9200.

```shell
如果使用了https需要做如下修改
修改kibana.yml配置，添加elasticsearch.ssl.verify: false

解决方法：
server.host: "0.0.0.0"
elasticsearch.url: "http://127.0.0.1:9200"
```
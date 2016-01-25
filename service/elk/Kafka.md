# Kafka

## 快速开始

[快速开始](http://kafka.apache.org/quickstart)

### 下载

```shell
wget http://apache.forsale.plus/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz

tar xf kafka_2.11-0.10.1.0.tgz -C /opt/
ln -s /opt/kafka_2.11-0.10.1.0/ /opt/kafka

cd /opt/kafka

mkdir /data/zookeeper

echo 2 > /data/zookeeper/myid

root@ubuntu75:/opt/kafka# bin/zookeeper-server-start.sh config/zookeeper.properties &[

root@ubuntu191:/opt/kafka# bin/zookeeper-server-start.sh config/zookeeper.properties &

root@ubuntu75:/opt/kafka# bin/kafka-server-start.sh config/server.properties &
```

## 报错信息

[2017-02-10 11:50:44,222] ERROR Setting LearnerType to PARTICIPANT but 3 not in QuorumPeers.  (org.apache.zookeeper.server.quorum.QuorumPeer)
[2017-02-10 11:50:44,226] INFO currentEpoch not found! Creating with a reasonable default of 0. This should only happen when you are upgrading your installation (org.apache.zookeeper.server.quorum.QuorumPeer)
[2017-02-10 11:50:44,239] INFO acceptedEpoch not found! Creating with a reasonable default of 0. This should only happen when you are upgrading your installation (org.apache.zookeeper.server.quorum.QuorumPeer)
[2017-02-10 11:50:44,253] ERROR Unexpected exception, exiting abnormally (org.apache.zookeeper.server.quorum.QuorumPeerMain)
java.lang.RuntimeException: My id 3 not in the peer list

root@ubuntu75:/opt/kafka# grep -vE "#|^$" config/zookeeper.properties
dataDir=/data/zookeeper
clientPort=2181
tickTime=2000
initLimit=20
syncLimit=10
server.1=10.174.217.111:2888:3888
server.2=10.174.214.247:2888:3888

说明：
    server后面的数字，写入到 cat /data/zookeeper/myid
由于配置文件里面没有3，所以报上述错误
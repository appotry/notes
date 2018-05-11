quickstart
==========

单一broker
----------

下载代码
~~~~~~~~

.. code:: shell

    cd src
    wget http://mirrors.cnnic.cn/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz
    tar xf kafka_2.11-0.10.1.0.tgz -C /opt/
    cd /opt/kafka_2.11-0.10.1.0/

kafka使用zookeeper,首先需要启动zookeeper
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    bin/zookeeper-server-start.sh config/zookeeper.properties

新开窗口,启动kafka
~~~~~~~~~~~~~~~~~~

::

    bin/kafka-server-start.sh config/server.properties

创建话题
~~~~~~~~

::

    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
    可以配置broker自动创建topics

查看topic
~~~~~~~~~

::

    bin/kafka-topics.sh --list --zookeeper localhost:2181

发送消息
~~~~~~~~

::

    每一行内容会被分为一条消息
    启动producer
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

启动一个consumer
~~~~~~~~~~~~~~~~

kafka有一个命令行的consumer,可以将消息显示到标准输出

新开一个窗口运行如下命令

::

    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

现在可以在刚刚启动的producer窗口发布消息,你将在consumer中看到

刚刚使用的命令行工具,不加参数运行可以查看帮助信息

.. figure:: http://oi480zo5x.bkt.clouddn.com/kafka-quickstart-2017222.jpg
   :alt: kafka-quickstart-2017222

   kafka-quickstart-2017222

创建一个多broker集群
--------------------

在同一台机器创建

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# pwd
    /opt/kafka_2.11-0.10.1.0

    cp config/server.properties config/server-1.properties
    cp config/server.properties config/server-2.properties

    编辑配置文件

    config/server-1.properties:
        broker.id=1
        listeners=PLAINTEXT://:9093
        log.dir=/tmp/kafka-logs-1

    config/server-2.properties:
        broker.id=2
        listeners=PLAINTEXT://:9094
        log.dir=/tmp/kafka-logs-2

集群中\ ``broker.id``\ 唯一识别一个节点,之前已经启动了zookeeper,所以只需要从刚刚生成的两个配置文件启动新的节点

启动kafka

::

    bin/kafka-server-start.sh config/server-1.properties &
    bin/kafka-server-start.sh config/server-2.properties &

创建一个具有三个副本的topic

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic
    Created topic "my-replicated-topic".

    replication-factor表示该topic需要在不同的broker中保存几份

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic
    Topic:my-replicated-topic   PartitionCount:1    ReplicationFactor:3 Configs:
        Topic: my-replicated-topic  Partition: 0    Leader: 0   Replicas: 0,2,1 Isr: 0,2,1

查看之前建立的topic

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic test
    Topic:test  PartitionCount:1    ReplicationFactor:1 Configs:
        Topic: test Partition: 0    Leader: 0   Replicas: 0 Isr: 0

    可以看到test topic没有副本,并且存放在server 0上

发布消息到新topic

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-console-producer.sh --broker-list localhost:9092 --topic my-replicated-topic

.. figure:: http://oi480zo5x.bkt.clouddn.com/kafka-quickstart2-2017222.jpg
   :alt: kafka-quickstart2-2017222

   kafka-quickstart2-2017222

测试容错
~~~~~~~~

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# ps aux |grep server.properties

    kill -9 PID

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic
    Topic:my-replicated-topic   PartitionCount:1    ReplicationFactor:3 Configs:
        Topic: my-replicated-topic  Partition: 0    Leader: 2   Replicas: 0,2,1 Isr: 2,1
    root@ubuntu47:/opt/kafka_2.11-0.10.1.0#

Leader切换到node 2,node 0不在在in-sync副本里,而消息仍然可用

使用Kafka Connect导入/导出数据
------------------------------

使用Kafka Connect从文件导入数据,以及导出数据到文件

.. code:: shell

    echo -e "foo\nbar" > test.txt
    bin/connect-standalone.sh config/connect-standalone.properties config/connect-file-source.properties config/connect-file-sink.properties

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# cat test.sink.txt
    foo
    bar
    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic connect-test --from-beginning
    {"schema":{"type":"string","optional":false},"payload":"foo"}
    {"schema":{"type":"string","optional":false},"payload":"bar"}

新窗口,echo “Another line” >> test.txt

可以看到如下信息,同时可以查看test.sink.txt

.. figure:: http://oi480zo5x.bkt.clouddn.com/kafka-quickstart3-2017222.jpg
   :alt: kafka-quickstart3-2017222

   kafka-quickstart3-2017222

使用Kafka Streams处理数据
-------------------------

.. code:: shell

    准备使用Kafka Streams处理的数据

    echo -e "all streams lead to kafka\nhello kafka streams\njoin kafka summit" > file-input.txt

    创建topic

    bin/kafka-topics.sh --create \
                --zookeeper localhost:2181 \
                --replication-factor 1 \
                --partitions 1 \
                --topic streams-file-input

    使用producer将数据输入到指定的topic

    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic streams-file-input < file-input.txt

新开窗口,执行如下命令

.. code:: shell

    运行WordCount,处理输入的数据,除了日志,不会有stdout,结果不断地写回另一个topic(streams-wordcount-output)

    bin/kafka-run-class.sh org.apache.kafka.streams.examples.wordcount.WordCountDemo

    检查WordCountDemo应用,从输出的topic读取

    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
                --topic streams-wordcount-output \
                --from-beginning \
                --formatter kafka.tools.DefaultMessageFormatter \
                --property print.key=true \
                --property print.value=true \
                --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
                --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer

    all 1
    lead    1
    to  1
    hello   1
    streams 2
    join    1
    kafka   3
    summit  1

    以上信息是输出到标准输出的内容,第一列是message的key,第二列是value,要注意的是,输出的实际是一个连续的更新流,其中每条数据(原始输出的每行)是一个单词的最新的count,又叫记录键"kafka".
    对于同一个key有多个记录,每个记录之后是前一个的更新.

.. figure:: http://oi480zo5x.bkt.clouddn.com/kafka-quickstart4-2017222.jpg
   :alt: kafka-quickstart4-2017222

   kafka-quickstart4-2017222

问题记录
--------

kafka启动失败,提示内存不足
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# bin/kafka-server-start.sh config/server-1.properties &
    [1] 10436
    root@ubuntu47:/opt/kafka_2.11-0.10.1.0# Java HotSpot(TM) 64-Bit Server VM warning: INFO: os::commit_memory(0x00000000c0000000, 1073741824, 0) failed; error='Cannot allocate memory' (errno=12)
    #
    # There is insufficient memory for the Java Runtime Environment to continue.
    # Native memory allocation (mmap) failed to map 1073741824 bytes for committing reserved memory.
    # An error report file with more information is saved as:
    # /opt/kafka_2.11-0.10.1.0/hs_err_pid10436.log

修改JVM堆大小,修改启动脚本中,KAFKA_HEAP_OPTS的值

.. code:: shell

    位置:
    bin/zookeeper-server-start.sh
    bin/kafka-server-start.sh

    if [ "x$KAFKA_HEAP_OPTS" = "x" ]; then
        export KAFKA_HEAP_OPTS="-Xmx256M -Xms256M"
    fi

修改-Xmm,-Xms,视服务器内存而定

Kafka Connect启动报错
~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    [2017-02-22 17:56:53,828] ERROR Failed to flush WorkerSourceTask{id=local-file-source-0}, timed out while waiting for producer to flush outstanding 1 messages (org.apache.kafka.connect.runtime.WorkerSourceTask:289)
    [2017-02-22 17:56:53,828] ERROR Failed to commit offsets for WorkerSourceTask{id=local-file-source-0} (org.apache.kafka.connect.runtime.SourceTaskOffsetCommitter:109)

确认kafka进程是否存在,可以暂停之后,重新启动kafka

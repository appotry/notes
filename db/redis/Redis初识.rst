Redis
=====

    什么是Redis？

-  Redis是一个开源的使用ANSI C语言编写的Key-Value 内存数据库
-  读写性能强，支持多种数据类型
-  把数据存储在内存中的高速缓存
-  作者Salvatore Sanfilippo

Redis简介
---------

特点
~~~~

.. code::

    * 速度快
    * 支持多种数据结构(string、list、hash、set、storted set)
    * 持久化
    * 主从复制（集群）
    * 支持过期时间
    * 支持事务
    * 消息订阅
    * 官方不支持WINDOWS，但是有第三方版本

Redis与Memcached的对比
~~~~~~~~~~~~~~~~~~~~~~

+----------+--------------+--------------+
| 项目     | Redis        | Memcached    |
+==========+==============+==============+
| 过期策略 | 支持         | 支持         |
+----------+--------------+--------------+
| 数据类型 | 五种数据类型 | 单一数据类型 |
+----------+--------------+--------------+
| 持久化   | 支持         | 不支持       |
+----------+--------------+--------------+
| 主从复制 | 支持         | 不支持       |
+----------+--------------+--------------+
| 虚拟内存 | 支持         | 不支持       |
+----------+--------------+--------------+
| 性能     | 性能         | 强           |
+----------+--------------+--------------+

Redis应用场景
~~~~~~~~~~~~~

    数据缓存

::

    提高访问性能，使用的方式与memcache相同

..

    会话缓存（Session Cache）

::

    保存web会话信息

..

    排行榜/计数器

::

    Nginx+lua+Redis计数器进行IP自动封禁。

..

    消息队列

::

    构建实时消息系统，聊天，群聊

安装配置
--------

安装
~~~~

.. code:: shell

    [root@web01 ~]# mkdir -p /data/server
    [root@web01 ~]# cd /data/server
    [root@web01 server]# wget http://download.redis.io/releases/redis-3.2.6.tar.gz
    [root@web01 server]# tar xf redis-3.2.6.tar.gz
    [root@web01 server]# cd redis-3.2.6
    [root@web01 redis-3.2.6]# make
    [root@web01 redis-3.2.6]# ln -s /data/server/redis-3.2.6/ /data/server/redis
    安装注意：
    直接make就行，在哪make的就安装在哪，不需要make install

..

    启动Redis

.. code:: shell

    [root@web01 redis-3.2.6]# src/redis-server
    56331:C 30 Dec 09:57:06.373 # Warning: no config file specified, using the default config. In order to specify a config file use src/redis-server /path/to/redis.conf
                    _._
               _.-``__ ''-._
          _.-``    `.  `_.  ''-._           Redis 3.2.6 (00000000/0) 64 bit
      .-`` .-```.  ```\/    _.,_ ''-._
     (    '      ,       .-`  | `,    )     Running in standalone mode
     |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
     |    `-._   `._    /     _.-'    |     PID: 56331
      `-._    `-._  `-./  _.-'    _.-'
     |`-._`-._    `-.__.-'    _.-'_.-'|
     |    `-._`-._        _.-'_.-'    |           http://redis.io
      `-._    `-._`-.__.-'_.-'    _.-'
     |`-._`-._    `-.__.-'    _.-'_.-'|
     |    `-._`-._        _.-'_.-'    |
      `-._    `-._`-.__.-'_.-'    _.-'
          `-._    `-.__.-'    _.-'
              `-._        _.-'
                  `-.__.-'

    56331:M 30 Dec 09:57:06.378 # Server started, Redis version 3.2.6
    56331:M 30 Dec 09:57:06.378 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
    56331:M 30 Dec 09:57:06.379 * The server is now ready to accept connections on port 6379

    ctrl +c

..

    默认Redis在前台启动，修改配置文件，让它后台启动

.. code:: shell

    修改daemonize
    [root@web01 redis-3.2.6]# vim redis.conf
    daemonize yes  # 128行

    后台运行，需要指定配置文件
    [root@web01 redis-3.2.6]# src/redis-server ./redis.conf
    [root@web01 redis-3.2.6]# ss -lntup|grep 6379
    tcp    LISTEN     0      511            127.0.0.1:6379                  *:*      users:(("redis-server",56389,4))

..

    登录客户端，默认为6379

.. code:: shell

    [root@web01 redis-3.2.6]# src/redis-cli
    127.0.0.1:6379>

    127.0.0.1:6379> set foo bar   ## foo 为 key，bar为值
    OK
    127.0.0.1:6379> get foo
    "bar"
    127.0.0.1:6379> set name yjj
    OK
    127.0.0.1:6379> keys *
    1) "name"
    2) "foo"
    127.0.0.1:6379> get name
    "yjj"
    127.0.0.1:6379> SHUTDOWN
    not connected> exit

服务管理文件
~~~~~~~~~~~~

.. code:: shell

    脚本内容见下面
        [root@web01 data]# cd /data/server/
        [root@web01 server]# cp redis.sh /etc/init.d/redis
        [root@web01 server]# chmod +x /etc/init.d/redis
        [root@web01 server]# service redis start
        Starting Redis server...
        [root@web01 server]# ss -lntup|grep redis
        tcp    LISTEN     0      511            127.0.0.1:6379                  *:*      users:(("redis-server",56528,4))

    脚本如果无法控制，因为pid文件名字问题，注意检查

    [root@web01 server]# grep pidfile /data/server/redis/redis.conf
    pidfile /var/run/redis.pid
    [root@web01 server]# grep PIDFILE= /etc/init.d/redis
    PIDFILE=/var/run/redis.pid

    脚本内容：
    [root@web01 redis]# cat /etc/init.d/redis
    #!/bin/sh
    #
    # Simple Redis init.d script conceived to work on Linux systems
    # as it does use of the /proc filesystem.
    # chkconfig: - 85 15
    REDISPORT=6379
    EXEC=/data/server/redis/src/redis-server
    CLIEXEC=/data/server/redis/src/redis-cli

    PIDFILE=/var/run/redis.pid
    CONF="/data/server/redis/redis.conf"

    case "$1" in
        start)
            if [ -f $PIDFILE ]
            then
                    echo "$PIDFILE exists, process is already running or crashed"
            else
                    echo "Starting Redis server..."
                    $EXEC $CONF
            fi
            ;;
        stop)
            if [ ! -f $PIDFILE ]
            then
                    echo "$PIDFILE does not exist, process is not running"
            else
                    PID=$(cat $PIDFILE)
                    echo "Stopping ..."
                    $CLIEXEC -p $REDISPORT shutdown
                    while [ -x /proc/${PID} ]
                    do
                        echo "Waiting for Redis to shutdown ..."
                        sleep 1
                    done
                    echo "Redis stopped"
            fi
            ;;
        status)
        if [ -f $PIDFILE ]
        then
            echo "redis server is running....."
        else
            echo "redis is stopped"
        fi
        ;;
        *)
            echo "Please use start or stop or status"
            ;;
    esac

一键部署
~~~~~~~~

.. code:: shell

    有需要请自行修改

    #!/bin/bash
    mkdir -p /data/rpm
    cd /data/rpm
    [ -f /data/rpm/redis-3.2.0.tar.gz ] || wget http://download.redis.io/releases/redis-3.2.0.tar.gz
    tar zxvf redis-3.2.0.tar.gz
    mv redis-3.2.0 /data/server/redis
    cd /data/server/redis
    make
    cp /data/scripts/redis/files/redis /etc/init.d
    rm -rf /data/server/redis/redis.conf
    cp /data/scripts/redis/files/redis.conf /data/server/redis/redis.conf
    chmod +x /etc/init.d/redis
    ln -s /data/server/redis/src/redis-cli /usr/bin/redis-cli
    chkconfig redis on
    service redis start
    service redis status

配置文件
~~~~~~~~

    主目录下：redis.conf

.. code:: shell

    daemonize no --->   yes                 # 后台运行
    port   6379                             # 端口Alessia Merz
    appendonly no --->  yes                 # 日志开关
    logfile stdout  --->  ./logs/redis.log  # 日志文件
    dbfilename dump.rdb                     # 持久化数据文件

保护模式
~~~~~~~~

-  Redis 3.2 新特性
-  解决访问安全
-  Bind与protected-mode
-  禁止protected-mode
-  增加bind
-  增加requirepass
-  auth {password}

配置文件详解
~~~~~~~~~~~~

.. code:: shell

    [root@web01 redis]# grep -vE "^$|#" redis.conf
    bind 127.0.0.1
    protected-mode yes
    port 6379
    tcp-backlog 511
    timeout 0
    tcp-keepalive 300
    daemonize yes
    supervised no
    pidfile /var/run/redis.pid
    loglevel notice
    logfile ""
    databases 16
    save 900 1
    save 300 10
    save 60 10000
    stop-writes-on-bgsave-error yes
    rdbcompression yes
    rdbchecksum yes
    dbfilename dump.rdb
    dir ./
    slave-serve-stale-data yes
    slave-read-only yes
    repl-diskless-sync no
    repl-diskless-sync-delay 5
    repl-disable-tcp-nodelay no
    slave-priority 100
    appendonly no
    appendfilename "appendonly.aof"
    appendfsync everysec
    no-appendfsync-on-rewrite no
    auto-aof-rewrite-percentage 100
    auto-aof-rewrite-min-size 64mb
    aof-load-truncated yes
    lua-time-limit 5000
    slowlog-log-slower-than 10000
    slowlog-max-len 128
    latency-monitor-threshold 0
    notify-keyspace-events ""
    hash-max-ziplist-entries 512
    hash-max-ziplist-value 64
    list-max-ziplist-size -2
    list-compress-depth 0
    set-max-intset-entries 512
    zset-max-ziplist-entries 128
    zset-max-ziplist-value 64
    hll-sparse-max-bytes 3000
    activerehashing yes
    client-output-buffer-limit normal 0 0 0
    client-output-buffer-limit slave 256mb 64mb 60
    client-output-buffer-limit pubsub 32mb 8mb 60
    hz 10
    aof-rewrite-incremental-fsync yes

.. code:: shell

    [root@web01 redis]# head redis.conf
    bind 127.0.0.1
    protected-mode yes
    requirepass root    ## 密码,设置密码之后，关闭redis可以使用shutdown命令
    port 6379
    tcp-backlog 511
    timeout 0
    tcp-keepalive 300
    daemonize yes
    supervised no
    pidfile /var/run/redis.pid

..

    重启redis

.. code:: shell

    [root@web01 redis]# src/redis-cli
    127.0.0.1:6379> keys *
    (error) NOAUTH Authentication required.
    127.0.0.1:6379> auth root
    OK
    127.0.0.1:6379> keys *
    (empty list or set)

运行配置
~~~~~~~~

.. code:: shell

    127.0.0.1:6379> config get *
    127.0.0.1:6379> config get requirepass
    1) "requirepass"
    2) "root"

    127.0.0.1:6379> config get loglevel
    1) "loglevel"
    2) "notice"
    127.0.0.1:6379> config set loglevel debug
    OK
    127.0.0.1:6379> config get loglevel
    1) "loglevel"
    2) "debug"

Redis数据存储
~~~~~~~~~~~~~

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/redis1-20161230.jpg
   :alt: redis1-20161230

   redis1-20161230

持久化
~~~~~~

-  RDB 持久化可以在指定的时间间隔内生成数据集的时间点快照（point-in-time
   snapshot）。
-  AOF
   持久化记录服务器执行的所有写操作命令，并在服务器启动时，通过重新执行这些命令来还原数据集。AOF
   文件中的命令全部以 Redis
   协议的格式来保存，新命令会被追加到文件的末尾。 Redis 还可以在后台对
   AOF 文件进行重写（rewrite），使得 AOF
   文件的体积不会超出保存数据集状态所需的实际大小。
-  Redis 还可以同时使用 AOF 持久化和 RDB 持久化。 在这种情况下，当 Redis
   重启时，它会优先使用AOF 文件来还原数据集，因为 AOF
   文件保存的数据集通常比 RDB 文件所保存的数据集更完整。
-  你甚至可以关闭持久化功能，让数据只在服务器运行时存在。

持久化策略
~~~~~~~~~~

    日志文件 appendonly yes/no

.. code::

    save 900 1       ## 900秒（15分钟）内有一个更改，存盘
    save 300 10      ## 300秒（5分钟）内有10个更改，存盘
    save 60 10000    ## 60秒内有10000个更改，即将数据写入磁盘

..

    压缩

.. code::

    dbcompression yes

    指定存储至本地数据库时是否压缩数据，默认为yes，Redis采用LZF压缩，如果为了节省CPU时间，可以关闭该选项，但会导致数据库文件变的巨大

..

    同步

.. code:: shell

    appendfsync everysec
        no：表示等操作系统进行数据缓存同步到磁盘（快）
        always：表示每次更新操作后手动调用fsync()将数据写到磁盘（慢，安全）
        everysec：表示每秒同步一次（折衷，默认值）

核心实践
--------

    数据类型

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/redis2-20161230.jpg
   :alt: redis2-20161230

   redis2-20161230

常规操作
~~~~~~~~

-  KEYS \* 查看KEY支持通配符
-  DEL删除给定的一个或多个key
-  EXISTS 检查是否存在
-  EXPIRE 设定生存时间
-  TTL以秒为单位返回过期时间
-  DUMP RESTORE序例化与反序列化
-  PEXIRE PTTL PERSIST 以毫秒为单位
-  RENAME 变更KEY名
-  SORT 键值排序
-  TYPE返回键所存储值的类型

字符串
~~~~~~

.. code:: shell

    SET name "guohz"
    Get name
    一个键最大能存储512MB

    Append将 value 追加到 key 原来的值的末尾
    Mget mset同时设置一个或多个键值对
    STRLEN 返回字符串长度
    INCR DECR 将值增或减1

    INCRBY DECRBY 减去指定量
    DECRBY count 20

Hash（哈希）
~~~~~~~~~~~~

-  Redis hash 是一个键值对集合。
-  Redis hash是一个string类型的field和value的映射表
-  hash特别适合用于存储对象。
-  每个 hash 可以存储 2^32-1 键值对

.. code:: shell

    HSET HGET 设置返回单个值
    HMSET HMGET 设置返回多个值
    Hmset user name guo sex male age 22

    HGETALL 返回KEY的所有键值
    HEXSITS HLEN
    HKEYS HVALS 获取所有字段或值
    HDEL 删除key 中的一个或多个指定域

LIST(列表)
~~~~~~~~~~

-  Redis列表是简单的字符串列表。
-  按照插入顺序排序每个
-  LIST可以存储 2^32 -1 键值对

.. code:: shell

    LPUSH 将一个或多个值插入到列表头部
    RPUSH将一个或多个值插入到列表尾部
    LPOP/RPOP 移除表头/尾的元素
    LLEN 返回列表长度
    LRANGE 返回指定的元素
    LREM greet 2 morning 删除前两个morning
    LREM greet -1 morning 删除后一个morning
    LREM greet 0 hello 删除所有hello


    Lindex 返回列表 key 中下标为 index 的元素.
    LSET key index value
        将列表 key 下标为 index 的元素的值设置为 value
    LINSERT 插入数据位于某元素之前或之后。
    LINSERT key BEFORE|AFTER pivot value

.. code:: shell

    操作
    127.0.0.1:6379> lpush list1 yang jin jie niu bi
    (integer) 5
    127.0.0.1:6379> lrange list1 0 2
    1) "bi"
    2) "niu"
    3) "jie"
    127.0.0.1:6379> lrange list1 0 10
    1) "bi"
    2) "niu"
    3) "jie"
    4) "jin"
    5) "yang"
    127.0.0.1:6379> lpush list1 z
    (integer) 6
    127.0.0.1:6379> lrange list1 0 10
    1) "z"
    2) "bi"
    3) "niu"
    4) "jie"
    5) "jin"
    6) "yang"
    127.0.0.1:6379> rpush list1 yjj
    (integer) 7
    127.0.0.1:6379> lrange list1 0 10
    1) "z"
    2) "bi"
    3) "niu"
    4) "jie"
    5) "jin"
    6) "yang"
    7) "yjj"
    127.0.0.1:6379> lpop list1
    "z"

    127.0.0.1:6379> lrange list1 0 10
    1) "bi"
    2) "niu"
    3) "jie"
    4) "jin"
    5) "yang"
    6) "yjj"
    127.0.0.1:6379> rpop list1
    "yjj"
    127.0.0.1:6379> lrange list1 0 10
    1) "bi"
    2) "niu"
    3) "jie"
    4) "jin"
    5) "yang"

    127.0.0.1:6379> lpush list1 morning afternoon morning
    (integer) 8
    127.0.0.1:6379> lrange list1 0 10
    1) "morning"
    2) "afternoon"
    3) "morning"
    4) "bi"
    5) "niu"
    6) "jie"
    7) "jin"
    8) "yang"
    127.0.0.1:6379> lrem list1 2 morning
    (integer) 2
    127.0.0.1:6379> lrange list1 0 10
    1) "afternoon"
    2) "bi"
    3) "niu"
    4) "jie"
    5) "jin"
    6) "yang"
    127.0.0.1:6379> lindex list1 2
    "niu"
    127.0.0.1:6379> lset list1 0 ok
    OK
    127.0.0.1:6379> lindex list1 0
    "ok"

    127.0.0.1:6379> linsert list1 after jie 123
    (integer) 7
    127.0.0.1:6379> lrange list1 0 10
    1) "ok"
    2) "bi"
    3) "niu"
    4) "jie"
    5) "123"
    6) "jin"
    7) "yang"

SET
~~~

-  Redis的Set是string类型的无序集合。
-  集合成员是唯一的，这就意味着集合中不能出现重复的数据。
-  Redis 中集合是通过哈希表实现的。

.. code:: shell

    SADD key member [member ...]
        将一个或多个 member 元素加入到集合 key 当中，已经存在于集合的 member 元素将被忽略。
    SCARD key 返回集合KEY的基数
    SDIFF key1 key2
        返回一个集合的全部成员，该集合是所有给定集合之间的差集，注意前后顺序。比较后Sdiffstore进行存储
    SMEMBERS key 查看成员的值
    SUNION 返回一个集合的全部成员，该集合是所有给定集合的并集。SUNIONSTORE

    SINTER key [key ...]
        返回一个集合的全部成员，该集合是所有给定集合的交集。SINTERSTORE
    SISMEMBER 判断是否属于该集合
    SMOVE source destination member
        将 member 元素从 source 集合移动到 destination 集合。
    SPOP SRANDMEMBER 移出或读取一个随机元素。
    SREM 移除集合中一个或多个元素

.. code:: shell

    127.0.0.1:6379> sadd set1 guohongze ztt zhao
    (integer) 3
    127.0.0.1:6379> scard set1
    (integer) 3
    127.0.0.1:6379> sadd set2 guohongze yangjinjie ztt lidaozhang
    (integer) 4
    127.0.0.1:6379> sdiff set1 set2  ## 用第一个去跟第二个比较，注意下面区别
    1) "zhao"
    127.0.0.1:6379> sdiff set2 set1
    1) "yangjinjie"
    2) "lidaozhang"

SortedSet(有序集合)
~~~~~~~~~~~~~~~~~~~

-  Redis 有序集合和集合一样也是string类型元素的集合,且不允许重复的成员。
-  每个元素都会关联一个double类型的分数。redis正是通过分数来为集合中的成员进行从小到大的排序。
-  有序集合的成员是唯一的,但分数(score)却可以重复。

.. code:: shell

    ZADD key score member
    ZCARD 返回有序集 key 的基数
    ZCOUNT key min max
        ZCOUNT salary 2000 5000 计算2000到5000之间的数
    ZSCORE key member 返回值
    ZINCRBY key increment member
        为score 值加上增量 increment，负数为减法
        ZINCRBY salary 2000 tom
    ZRANGE key start stop 返回指定区间成员
        ZRANGE salary 0 -1 WITHSCORES # 显示所有

    ZRANGEBYSCORE
        有序集成员按 score 值递增(从小到大)次序排列。
        ZRANGEBYSCORE salary -inf +inf WITHSCORES
    ZRANK key member 显示排名
        ZRANGE salary 0 -1 WITHSCORES
        ZRANGE salary tom
    ZREM key member 移除一个或多个成员。
        ZREMRANGEBYRANK ZREMRANGEBYSCORE 移除
    ZREVRANGE key start stop [WITHSCORES]
        递减返回值

.. code:: shell

    127.0.0.1:6379> zadd salary 10000 guohongze
    (integer) 1
    127.0.0.1:6379> zscore salary guohongze
    "10000"
    127.0.0.1:6379> zadd salary 15000 zhaobanzhang
    (integer) 1
    127.0.0.1:6379> zadd salary 13000 laoban
    (integer) 1
    127.0.0.1:6379> zadd salary 9000 xiaoming
    (integer) 1
    127.0.0.1:6379> zcount salary 10000 20000
    (integer) 3
    127.0.0.1:6379> zincrby salary 1000 guohongze
    "11000"
    127.0.0.1:6379> zscore salary guohongze
    "11000"
    127.0.0.1:6379> zincrby salary -1000 xiaoming
    "8000"
    127.0.0.1:6379> zrange salary 0 -1 withscores
    1) "xiaoming"
    2) "8000"
    3) "guohongze"
    4) "11000"
    5) "laoban"
    6) "13000"
    7) "zhaobanzhang"
    8) "15000"
    127.0.0.1:6379> zrange salary 0 1 withscores
    1) "xiaoming"
    2) "8000"
    3) "guohongze"
    4) "11000"

    127.0.0.1:6379> zrangebyscore salary -inf +inf withscores
    1) "xiaoming"
    2) "8000"
    3) "guohongze"
    4) "11000"
    5) "laoban"
    6) "13000"
    7) "zhaobanzhang"
    8) "15000"
    127.0.0.1:6379> zrangebyscore salary 10000 20000 withscores
    1) "guohongze"
    2) "11000"
    3) "laoban"
    4) "13000"
    5) "zhaobanzhang"
    6) "15000"
    127.0.0.1:6379> zrangebyscore salary 10000 20000
    1) "guohongze"
    2) "laoban"
    3) "zhaobanzhang"

    127.0.0.1:6379> zrem salary xiaoming
    (integer) 1

    127.0.0.1:6379> zrevrange salary 0 -1 withscores
    1) "zhaobanzhang"
    2) "15000"
    3) "laoban"
    4) "13000"
    5) "guohongze"
    6) "11000"

Redis 高级应用
--------------

生产消费模型
~~~~~~~~~~~~

    消息模式

::

    发布消息通常有两种模式：队列模式（queuing）和发布-订阅模式(publish-subscribe)。队列模式中，consumers可以同时从服务端读取消息，每个消息只被其中一个consumer读到。

    发布-订阅模式中消息被广播到所有的consumer中，topic中的消息将被分发到组中的一个成员中。同一组中的consumer可以在不同的程序中，也可以在不同的机器上。

..

    Redis 发布订阅

::

    Redis 发布订阅(pub/sub)是一种消息通信模式：发送者(pub)发送消息，订阅者(sub)接收消息。
    Redis 客户端可以订阅任意数量的频道。

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/redis3-20161230.jpg
   :alt: redis3-20161230

   redis3-20161230

订阅发布实例
~~~~~~~~~~~~

SUBSCRIBE mq1 #客户端 PUBLISH mq1 “Redis is a great caching technique”

::

    PSUBSCRIBE订阅一个或多个符合给定模式的频道。
        psubscribe news.* tech.*
    PUBLISH channel message
        将信息 message 发送到指定的频道 channel 。返回值代表消费者数量
    pubsub channels 显示订阅频道
        PUBSUB NUMSUB news.it 打印各频道订阅者数量

    PUNSUBSCRIBE 退订多个频道
    SUBSCRIBE 订阅给定的一个或多个频道的信息。
    UNSUBSCRIBE 退订频道

..

    实例

.. code:: shell

    127.0.0.1:6379> subscribe channel1
    Reading messages... (press Ctrl-C to quit)
    1) "subscribe"
    2) "channel1"
    3) (integer) 1
    新开窗口，继续做如上操作
        127.0.0.1:6379> subscribe channel1
        Reading messages... (press Ctrl-C to quit)
        1) "subscribe"
        2) "channel1"
        3) (integer) 1

    显示订阅频道
    127.0.0.1:6379> pubsub channels
    1) "channel1"

    127.0.0.1:6379> pubsub numsub channel1
    1) "channel1"
    2) (integer) 2

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/订阅发布实例-20161230.jpg
   :alt: 订阅发布实例-20161230

   订阅发布实例-20161230

事务
~~~~

-  Redis 事务可以一次执行多个命令。

   -  事务是一个单独的隔离操作：事务中的所有命令都会序列化、按顺序地执行。事务在执行的过程中，不会被其他客户端发送来的命令请求所打断。
   -  原子性：事务中的命令要么全部被执行，要么全部都不执行。

-  执行过程

   -  开始事务。
   -  命令入队。
   -  执行事务。

..

    事务命令

.. code:: shell

    DISCARD
        取消事务，放弃执行事务块内的所有命令。
    EXEC
        执行所有事务块内的命令。
    MULTI
        标记一个事务块的开始。
    UNWATCH
        取消 WATCH 命令对所有 key 的监视。
    WATCH key [key ...]
        监视一个(或多个) key ，如果在事务执行之前这个(或这些) key 被其他命令所改动，那么事务将被打断。

..

    事务执行

.. code:: shell

    范例：

    zadd salary 2000 guohongze
    zadd salary 3000 test
    ZRANGE salary 0 -1 WITHSCORES
    MULTI
        - ZINCRBY salary 1000 guohongze
        - zincrby salary -1000 test
        - EXEC

.. code:: shell

    [root@web01 ~]# redis-cli
    127.0.0.1:6379> auth root
    OK
    127.0.0.1:6379> MULTI
    OK
    127.0.0.1:6379> zincrby salary -1000 laoban
    QUEUED
    127.0.0.1:6379> ZINCRBY salary 1000 guohongze
    QUEUED
    127.0.0.1:6379> EXEC
    1) "12000"
    2) "12000"

    执行exec 前
        127.0.0.1:6379> zrange salary 0 -1 withscores
        1) "guohongze"
        2) "11000"
        3) "laoban"
        4) "13000"
        5) "zhaobanzhang"
        6) "15000"

    执行exec后
        127.0.0.1:6379> zrange salary 0 -1 withscores
        1) "guohongze"
        2) "12000"
        3) "laoban"
        4) "12000"
        5) "zhaobanzhang"
        6) "15000"

服务器命令
~~~~~~~~~~

-  Info
-  Clinet list
-  Client kill ip:port
-  config get \*
-  CONFIG RESETSTAT 重置统计
-  CONFIG GET/SET 动态修改
-  Dbsize 查看key的数量
-  FLUSHALL 清空所有数据 select 1
-  FLUSHDB 清空当前库
-  MONITOR 监控实时指令

-  SHUTDOWN 关闭服务器
-  save 将当前数据保存
-  SLAVEOF host port 主从配置
-  SLAVEOF NO ONE
-  SYNC 主从同步
-  ROLE返回主从角色

.. code:: shell

    127.0.0.1:6379> client list
    id=6 addr=127.0.0.1:38172 fd=5 name= age=13214 idle=1132 flags=N db=0 sub=1 psub=0 multi=-1 qbuf=0 qbuf-free=0 obl=0 oll=0 omem=0 events=r cmd=subscribe
    id=8 addr=127.0.0.1:40574 fd=7 name= age=1166 idle=899 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=0 obl=0 oll=0 omem=0 events=r cmd=pubsub
    id=9 addr=127.0.0.1:40658 fd=6 name= age=752 idle=0 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=32768 obl=0 oll=0 omem=0 events=r cmd=client
    id=11 addr=127.0.0.1:40739 fd=8 name= age=353 idle=353 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=0 obl=0 oll=0 omem=0 events=r cmd=command

.. code:: shell

    127.0.0.1:6379> dbsize
    (integer) 5

.. code:: shell

    127.0.0.1:6379> monitor
    OK

    新开窗口 执行
    127.0.0.1:6379> set foo bar
    OK

    原窗口查看
    1483082063.661610 [0 127.0.0.1:40574] "set" "foo" "bar"

慢日志查询
~~~~~~~~~~

-  Slow log 是 Redis 用来记录查询执行时间的日志系统。
-  slow log 保存在内存里面，读写速度非常快
-  可以通过改写 redis.conf 文件或者用 CONFIG GET 和 CONFIG SET
   命令对它们动态地进行修改
-  slowlog-log-slower-than 10000 超过多少微秒
-  CONFIG SET slowlog-log-slower-than 100
-  CONFIG SET slowlog-max-len 1000 保存多少条慢日志
-  CONFIG GET slow\*
-  SLOWLOG GET
-  SLOWLOG RESET

.. code:: shell

    127.0.0.1:6379> config get slow*
    1) "slowlog-log-slower-than"
    2) "10000"
    3) "slowlog-max-len"
    4) "128"
    127.0.0.1:6379> config set slowlog-max-len 256
    OK
    127.0.0.1:6379> config get slow*
    1) "slowlog-log-slower-than"
    2) "10000"
    3) "slowlog-max-len"
    4) "256"

数据备份
~~~~~~~~

-  CONFIG GET dir 获取当前目录
-  Save 备份（无持久化策略时），生成时在redis当前目录中。
-  恢复时只需将dump.rdb放入redis当前目录

.. code:: shell

    127.0.0.1:6379> config get dir
    1) "dir"
    2) "/"

    127.0.0.1:6379> config set dir /data/server/redis
    OK
    127.0.0.1:6379> config get dir
    1) "dir"
    2) "/data/server/redis-3.2.6"
    127.0.0.1:6379> save
    OK

redis 复制
----------

-  从 Redis 2.8 开始，使用异步复制。
-  一个主服务器可以有多个从服务器。
-  从服务器也可以有自己的从服务器。
-  复制功能不会阻塞主服务器。
-  可以通过复制功能来让主服务器免于执行持久化操作，由从服务器去执行持久化操作即可。

主从配置
~~~~~~~~

.. code:: shell

    slaveof 192.168.1.1 6379
    slave-read-only 只读模式
    masterauth <password> 主服务器设置密码后需要填写密码
    min-slaves-to-write <number of slaves>
        从服务器不少于，才允许写入
    min-slaves-max-lag <number of seconds>
        从服务器延迟不大于
    CONFIG set slave-read-only yes
    Config set masterauth root
    INFO replication
    SLAVEOF NO ONE 升级至MASTER

.. code:: shell

    [root@web01 server]# pwd
    /data/server
    [root@web01 server]# mkdir 8000 8001
    cp redis/redis.conf 8000
    cp redis/redis.conf 8001
    cp redis/src/redis-server 8000
    cp redis/src/redis-server 8001

    修改配置文件

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/redis-master-slave-20161230.jpg
   :alt: redis-master-slave-20161230

   redis-master-slave-20161230

.. code:: shell

    [root@web01 server]# ./8000/redis-server ./8000/redis.conf
    [root@web01 server]# ./8001/redis-server ./8001/redis.conf
    [root@web01 8002]# ss -lntup|grep redis
    tcp    LISTEN     0      511            127.0.0.1:8000                  *:*      users:(("redis-server",57766,4))
    tcp    LISTEN     0      511            127.0.0.1:8001                  *:*      users:(("redis-server",57867,4))
    tcp    LISTEN     0      511            127.0.0.1:6379                  *:*      users:(("redis-server",57142,4))

    [root@web01 server]# redis-cli -p 8000
    127.0.0.1:8000> role
    1) "master"
    2) (integer) 197
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "197"

..

    再加一个slave

.. code:: shell

    [root@web01 server]# cp -r 8001 8002
    [root@web01 server]# cd 8002
    [root@web01 8002]# ll
    total 7652
    -rw-r--r-- 1 root root      76 Dec 30 16:06 dump.rdb
    -rw-r--r-- 1 root root    1194 Dec 30 16:06 redis.conf
    -rwxr-xr-x 1 root root 7826344 Dec 30 16:06 redis-server
    [root@web01 8002]# rm -f dump.rdb
    [root@web01 8002]# vim redis.conf

    port 8002
    pidfile /var/run/redis_8002.pid

    ---------
    [root@web01 8002]# ss -lntup |grep 8002
    tcp    LISTEN     0      511            127.0.0.1:8002                  *:*      users:(("redis-server",57893,4))

    8000 查看角色

    127.0.0.1:8000> role
    1) "master"
    2) (integer) 421
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "421"
       2) 1) "127.0.0.1"
          2) "8002"
          3) "421"

..

    客户端登录执行slaveof，重启后失效

.. code:: shell

    [root@web01 server]# cp -r 8000 8003
    [root@web01 server]# cd 8003
    [root@web01 8003]# ll
    total 7652
    -rw-r--r-- 1 root root      76 Dec 30 16:09 dump.rdb
    -rw-r--r-- 1 root root    1171 Dec 30 16:09 redis.conf
    -rwxr-xr-x 1 root root 7826344 Dec 30 16:09 redis-server
    [root@web01 8003]# rm -f dump.rdb
    [root@web01 8003]# vim redis.conf
    port 8003
    pidfile /var/run/redis_8003.pid
    ----配置文件没有添加slaveof
    [root@web01 8003]# ./redis-server ./redis.conf

    8000 role角色没有变化
    127.0.0.1:8000> role

    127.0.0.1:8003> slaveof 127.0.0.1 8000
    OK

    重新查看8000  role角色
    127.0.0.1:8000> role
    1) "master"
    2) (integer) 869
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "869"
       2) 1) "127.0.0.1"
          2) "8002"
          3) "869"
       3) 1) "127.0.0.1"
          2) "8003"
          3) "869"

..

    开启主从复制之后，从库自动开启read-only

.. code:: shell

    127.0.0.1:8003> config get slave-read-only
    1) "slave-read-only"
    2) "yes"

..

    info replication

.. code:: shell

    127.0.0.1:8003> info replication
    # Replication
    role:slave
    master_host:127.0.0.1
    master_port:8000
    master_link_status:up
    master_last_io_seconds_ago:6
    master_sync_in_progress:0
    slave_repl_offset:1135
    slave_priority:100
    slave_read_only:1
    connected_slaves:0
    master_repl_offset:0
    repl_backlog_active:0
    repl_backlog_size:1048576
    repl_backlog_first_byte_offset:0
    repl_backlog_histlen:0

..

    主从手动切换

.. code:: shell

    127.0.0.1:8000> shutdown
    not connected> exit
    [root@web01 server]# redis-cli -p 8001
    127.0.0.1:8001> slaveof no one
    OK
    127.0.0.1:8001> role
    1) "master"
    2) (integer) 0
    3) (empty list or set)
    127.0.0.1:8001> exit
    [root@web01 server]# redis-cli -p 8002
    127.0.0.1:8002> slaveof 127.0.0.1 8001
    OK
    127.0.0.1:8002> role
    1) "slave"
    2) "127.0.0.1"
    3) (integer) 8001
    4) "connected"
    5) (integer) 1

    127.0.0.1:8003> slaveof 127.0.0.1 8001
    OK

    [root@web01 server]# redis-cli -p 8001
    127.0.0.1:8001> role
    1) "master"
    2) (integer) 71
    3) 1) 1) "127.0.0.1"
          2) "8002"
          3) "71"
       2) 1) "127.0.0.1"
          2) "8003"
          3) "71"

基于keepalived的自动故障切换
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Redis Sentinel
~~~~~~~~~~~~~~

    Redis-Sentinel是Redis官方推荐的高可用性(HA)解决方案，当用Redis做Master-slave的高可用方案时，假如master宕机了，Redis本身(包括它的很多客户端)都没有实现自动进行主备切换，而Redis-sentinel本身也是一个独立运行的进程，它能监控多个master-slave集群，发现master宕机后能进行自动切换。

..

    功能

.. code::

    监控（Monitoring）： Sentinel 会不断地检查你的主服务器和从服务器是否运作正常。
    提醒（Notification）： 当被监控的某个 Redis 服务器出现问题时， Sentinel 可以通过 API 向管理员或者其他应用程序发送通知。
    自动故障迁移（Automatic failover）： 当一个主服务器不能正常工作时， Sentinel 会开始一次自动故障迁移操作， 它会将失效主服务器的其中一个从服务器升级为新的主服务器， 并让失效主服务器的其他从服务器改为复制新的主服务器； 当客户端试图连接失效的主服务器时， 集群也会向客户端返回新主服务器的地址， 使得集群可以使用新主服务器代替失效服务器。

..

    配置记录，详细操作见下文

.. code:: shell

    mkdir 8000 8001 8002
    cp src/redis-sentinel sentinel.conf 8000 8001 8002
    cd 7000
    vim sentinel
    sentinel monitor mymaster 127.0.0.1 6380 2

    ./redis-sentinel ./sentinel.conf

    配置文件：
    指定监控master
        sentinel monitor mymaster 127.0.0.1 6379 2   ## sentinel也可以做高可用，后面的2表示两台sentinel同时检测到master挂掉
    安全信息
        sentinel auth-pass mymaster luyx30
    超过15000毫秒后认为主机宕机
        sentinel down-after-milliseconds mymaster 15000
    和当主从切换多久后认为主从切换失败
        sentinel failover-timeout mymaster 900000
    这两个配置后面的数量主从机需要一样
        sentinel leader-epoch mymaster 1
        sentinel config-epoch mymaster 1
        具体查看sentinel高可用

..

    恢复现场

.. code:: shell

    [root@web01 8000]# ./redis-server ./redis.conf
    [root@web01 8000]# redis-cli -p 8001
    127.0.0.1:8001> slaveof 127.0.0.1 8000
    OK
    127.0.0.1:8001>
    [root@web01 8000]# redis-cli -p 8002
    127.0.0.1:8002> slaveof 127.0.0.1 8000
    OK
    127.0.0.1:8002>
    [root@web01 8000]# redis-cli -p 8003
    127.0.0.1:8003> slaveof 127.0.0.1 8000
    OK
    127.0.0.1:8003>
    [root@web01 8000]# redis-cli -p 8000
    127.0.0.1:8000> role
    1) "master"
    2) (integer) 29
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "29"
       2) 1) "127.0.0.1"
          2) "8002"
          3) "29"
       3) 1) "127.0.0.1"
          2) "8003"
          3) "29"

.. code:: shell

    [root@web01 server]# pwd
    /data/server
    [root@web01 server]# mkdir sentinel
    [root@web01 server]# cp redis/sentinel.conf sentinel/
    [root@web01 server]# cp redis/src/redis-sentinel sentinel/
    [root@web01 sentinel]# ll
    total 7652
    -rwxr-xr-x 1 root root 7826344 Dec 30 16:32 redis-sentinel
    -rw-r--r-- 1 root root    7606 Dec 30 16:32 sentinel.conf
    [root@web01 sentinel]# egrep -v "^$|#" sentinel.conf > sentinel.conf1
    [root@web01 sentinel]# mv sentinel.conf sentinel.conf.bak
    [root@web01 sentinel]# mv sentinel.conf1 sentinel.conf
    [root@web01 sentinel]# ls
    redis-sentinel  sentinel.conf  sentinel.conf.bak
    [root@web01 sentinel]# cat sentinel.conf
    port 26379
    dir /tmp
    sentinel monitor mymaster 127.0.0.1 6379 2
    sentinel down-after-milliseconds mymaster 30000
    sentinel parallel-syncs mymaster 1
    sentinel failover-timeout mymaster 180000

    [root@web01 sentinel]# sed -i.ori 's#127.0.0.1 6379 2#127.0.0.1 8000 1#g' sentinel.conf
    [root@web01 sentinel]# cat sentinel.conf
    port 26379
    dir /tmp
    sentinel monitor mymaster 127.0.0.1 8000 1
    sentinel down-after-milliseconds mymaster 30000
    sentinel parallel-syncs mymaster 1
    sentinel failover-timeout mymaster 180000

..

    启动sentinel

.. code:: shell

    [root@web01 sentinel]# ./redis-sentinel sentinel.conf
                    _._
               _.-``__ ''-._
          _.-``    `.  `_.  ''-._           Redis 3.2.6 (00000000/0) 64 bit
      .-`` .-```.  ```\/    _.,_ ''-._
     (    '      ,       .-`  | `,    )     Running in sentinel mode
     |`-._`-...-` __...-.``-._|'` _.-'|     Port: 26379
     |    `-._   `._    /     _.-'    |     PID: 58031
      `-._    `-._  `-./  _.-'    _.-'
     |`-._`-._    `-.__.-'    _.-'_.-'|
     |    `-._`-._        _.-'_.-'    |           http://redis.io
      `-._    `-._`-.__.-'_.-'    _.-'
     |`-._`-._    `-.__.-'    _.-'_.-'|
     |    `-._`-._        _.-'_.-'    |
      `-._    `-._`-.__.-'_.-'    _.-'
          `-._    `-.__.-'    _.-'
              `-._        _.-'
                  `-.__.-'

    58031:X 30 Dec 16:38:20.142 # Sentinel ID is ee6562c23b9b3e7309015019318659860351105a
    58031:X 30 Dec 16:38:20.143 # +monitor master mymaster 127.0.0.1 8000 quorum 1
    58031:X 30 Dec 16:38:20.144 * +slave slave 127.0.0.1:8001 127.0.0.1 8001 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:38:20.146 * +slave slave 127.0.0.1:8002 127.0.0.1 8002 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:38:20.149 * +slave slave 127.0.0.1:8003 127.0.0.1 8003 @ mymaster 127.0.0.1 8000

    此时它会自动在配置文件里面写入部分内容

..

    新开窗口，关闭8000 redis

.. code:: shell

    127.0.0.1:8000> SHUTDOWN [NOSAVE|SAVE]

    之前窗口会显示日志信息：
    58031:X 30 Dec 16:43:55.941 # +sdown master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:55.941 # +odown master mymaster 127.0.0.1 8000 #quorum 1/1
    58031:X 30 Dec 16:43:55.941 # +new-epoch 1
    58031:X 30 Dec 16:43:55.941 # +try-failover master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:55.943 # +vote-for-leader ee6562c23b9b3e7309015019318659860351105a 1
    58031:X 30 Dec 16:43:55.943 # +elected-leader master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:55.943 # +failover-state-select-slave master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.000 # +selected-slave slave 127.0.0.1:8002 127.0.0.1 8002 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.000 * +failover-state-send-slaveof-noone slave 127.0.0.1:8002 127.0.0.1 8002 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.052 * +failover-state-wait-promotion slave 127.0.0.1:8002 127.0.0.1 8002 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.370 # +promoted-slave slave 127.0.0.1:8002 127.0.0.1 8002 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.370 # +failover-state-reconf-slaves master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:56.468 * +slave-reconf-sent slave 127.0.0.1:8001 127.0.0.1 8001 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:57.383 * +slave-reconf-inprog slave 127.0.0.1:8001 127.0.0.1 8001 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:57.383 * +slave-reconf-done slave 127.0.0.1:8001 127.0.0.1 8001 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:57.446 * +slave-reconf-sent slave 127.0.0.1:8003 127.0.0.1 8003 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:58.392 * +slave-reconf-inprog slave 127.0.0.1:8003 127.0.0.1 8003 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:59.480 * +slave-reconf-done slave 127.0.0.1:8003 127.0.0.1 8003 @ mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:59.579 # +failover-end master mymaster 127.0.0.1 8000
    58031:X 30 Dec 16:43:59.579 # +switch-master mymaster 127.0.0.1 8000 127.0.0.1 8002
    58031:X 30 Dec 16:43:59.579 * +slave slave 127.0.0.1:8001 127.0.0.1 8001 @ mymaster 127.0.0.1 8002
    58031:X 30 Dec 16:43:59.579 * +slave slave 127.0.0.1:8003 127.0.0.1 8003 @ mymaster 127.0.0.1 8002
    58031:X 30 Dec 16:43:59.579 * +slave slave 127.0.0.1:8000 127.0.0.1 8000 @ mymaster 127.0.0.1 8002
    58031:X 30 Dec 16:44:29.643 # +sdown slave 127.0.0.1:8000 127.0.0.1 8000 @ mymaster 127.0.0.1 8002


    根据日志 可以看到主切换到了8002

    新开窗口，登录8002，查看role
    [root@web01 8000]# redis-cli -p 8002
    127.0.0.1:8002> role
    1) "master"
    2) (integer) 5190
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "5190"
       2) 1) "127.0.0.1"
          2) "8003"
          3) "5190"

..

    重新启动8000

.. code:: shell

    [root@web01 8000]# ./redis-server ./redis.conf

    查看之前日志窗口，会显示日志信息：
    58031:X 30 Dec 16:45:59.979 # -sdown slave 127.0.0.1:8000 127.0.0.1 8000 @ mymaster 127.0.0.1 8002
    58031:X 30 Dec 16:46:09.974 * +convert-to-slave slave 127.0.0.1:8000 127.0.0.1 8000 @ mymaster 127.0.0.1 8002

..

    登录查看8002

.. code:: shell

    [root@web01 8000]# redis-cli -p 8002
    127.0.0.1:8002> role
    1) "master"
    2) (integer) 12682
    3) 1) 1) "127.0.0.1"
          2) "8001"
          3) "12682"
       2) 1) "127.0.0.1"
          2) "8003"
          3) "12682"
       3) 1) "127.0.0.1"
          2) "8000"
          3) "12682"

sentinel命令
~~~~~~~~~~~~

-  PING ：返回 PONG 。
-  SENTINEL masters ：列出所有被监视的主服务器
-  SENTINEL slaves
-  SENTINEL get-master-addr-by-name ： 返回给定名字的主服务器的 IP
   地址和端口号。
-  SENTINEL reset ： 重置所有名字和给定模式 pattern 相匹配的主服务器。
-  SENTINEL failover ： 当主服务器失效时， 在不询问其他 Sentinel
   意见的情况下， 强制开始一次自动故障迁移。

.. code:: shell

    [root@web01 8000]# redis-cli -p 26379
    127.0.0.1:26379>
    127.0.0.1:26379> sentinel masters
    1)  1) "name"
        2) "mymaster"
        3) "ip"
        4) "127.0.0.1"
        5) "port"
        6) "8002"
        7) "runid"
        8) "8b76427cae519ae65a1e2474ce6944e064137db4"
        9) "flags"
       10) "master"
       11) "link-pending-commands"
       12) "0"
       13) "link-refcount"
       14) "1"
       15) "last-ping-sent"
       16) "0"
       17) "last-ok-ping-reply"
       18) "414"
       19) "last-ping-reply"
       20) "414"
       21) "down-after-milliseconds"
       22) "30000"
       23) "info-refresh"
       24) "8712"
       25) "role-reported"
       26) "master"
       27) "role-reported-time"
       28) "321004"
       29) "config-epoch"
       30) "1"
       31) "num-slaves"
       32) "3"
       33) "num-other-sentinels"
       34) "0"
       35) "quorum"
       36) "1"
       37) "failover-timeout"
       38) "180000"
       39) "parallel-syncs"
       40) "1"

Redis Cluster
-------------

Redis集群
~~~~~~~~~

-  Redis 集群是一个可以在多个 Redis
   节点之间进行数据共享的设施（installation）。
-  Redis 集群不支持那些需要同时处理多个键的 Redis 命令，
   因为执行这些命令需要在多个 Redis 节点之间移动数据，
   并且在高负载的情况下， 这些命令将降低 Redis 集群的性能，
   并导致不可预测的行为。
-  Redis
   集群通过分区（partition）来提供一定程度的可用性（availability）：
   即使集群中有一部分节点失效或者无法进行通讯，
   集群也可以继续处理命令请求。
-  将数据自动切分（split）到多个节点的能力。
-  当集群中的一部分节点失效或者无法进行通讯时，
   仍然可以继续处理命令请求的能力。

Redis 集群数据共享
~~~~~~~~~~~~~~~~~~

-  Redis 集群使用数据分片（sharding）而非一致性哈希（consistency
   hashing）来实现： 一个 Redis 集群包含 16384 个哈希槽（hash slot），
   数据库中的每个键都属于这 16384 个哈希槽的其中一个， 集群使用公式
   CRC16(key) % 16384 来计算键 key 属于哪个槽， 其中 CRC16(key)
   语句用于计算键 key 的 CRC16 校验和 。

-  节点 A 负责处理 0 号至 5500 号哈希槽。
-  节点 B 负责处理 5501 号至 11000 号哈希槽。
-  节点 C 负责处理 11001 号至 16384 号哈希槽。

集群的复制
~~~~~~~~~~

-  为了使得集群在一部分节点下线或者无法与集群的大多数（majority）节点进行通讯的情况下，
   仍然可以正常运作， Redis 集群对节点使用了主从复制功能：
   集群中的每个节点都有 1 个至 N 个复制品（replica），
   其中一个复制品为主节点（master）， 而其余的 N-1
   个复制品为从节点（slave）。
-  在之前列举的节点 A 、B 、C 的例子中， 如果节点 B 下线了，
   那么集群将无法正常运行， 因为集群找不到节点来处理 5501 号至 11000
   号的哈希槽。
-  假如在创建集群的时候（或者至少在节点 B 下线之前）， 我们为主节点 B
   添加了从节点 B1 ， 那么当主节点 B 下线的时候， 集群就会将 B1
   设置为新的主节点， 并让它代替下线的主节点 B ， 继续处理 5501 号至
   11000 号的哈希槽， 这样集群就不会因为主节点 B
   的下线而无法正常运作了。
-  不过如果节点 B 和 B1 都下线的话， Redis 集群还是会停止运作。

Redis Cluster

.. figure:: http://oi480zo5x.bkt.clouddn.com/Linux_project/Redis%20Cluster-20161230.jpg
   :alt: Redis Cluster-20161230

   Redis Cluster-20161230

运行机制
~~~~~~~~

-  所有的redis节点彼此互联(PING-PONG机制),内部使用二进制协议优化传输速度和带宽.
-  节点的fail是通过集群中超过半数的master节点检测失效时才生效.
-  客户端与redis节点直连,不需要中间proxy层.客户端不需要连接集群所有节点,连接集群中任何一个可用节点即可
-  把所有的物理节点映射到[0-16383]slot上,cluster
   负责维护node<->slot<->key

配置cluster
~~~~~~~~~~~

.. code:: shell

    需要安装ruby支持
    yum install ruby rubygems –y
    gem install redis

    [root@web01 8000]# yum install -y ruby rubygems
    [root@web01 8000]# gem install redis
    Fetching: redis-3.3.2.gem (100%)
    Successfully installed redis-3.3.2
    Parsing documentation for redis-3.3.2
    Installing ri documentation for redis-3.3.2
    Done installing documentation for redis after 1 seconds
    1 gem installed

..

    配置文件redis.conf需要添加如下配置

.. code:: shell

        cluster-enabled yes
        cluster-config-file nodes.conf
        cluster-node-timeout 5000
        appendonly yes
        并删除 slaveof

..

    添加多个实例，并配置

.. code:: shell

    [root@web01 server]# cp -r 8003 8004
    [root@web01 server]# cp -r 8003 8005
    [root@web01 server]# cd 8000
    [root@web01 8000]# ls
    dump.rdb  redis.conf  redis-server
    [root@web01 8000]# rm dump.rdb -f
    并按上述内容添加，其他实例同样操作

    启动
    [root@web01 server]# for n in {0..5};do ./800$n/redis-server ./800$n/redis.conf;done
    [root@web01 redis]# ss -lntup|grep redis
    tcp    LISTEN     0      511            127.0.0.1:8000                  *:*      users:(("redis-server",58282,4))
    tcp    LISTEN     0      511            127.0.0.1:8001                  *:*      users:(("redis-server",58286,4))
    tcp    LISTEN     0      511            127.0.0.1:8002                  *:*      users:(("redis-server",58290,4))
    tcp    LISTEN     0      511            127.0.0.1:8003                  *:*      users:(("redis-server",58292,4))
    tcp    LISTEN     0      511            127.0.0.1:8004                  *:*      users:(("redis-server",58412,4))
    tcp    LISTEN     0      511            127.0.0.1:8005                  *:*      users:(("redis-server",58389,4))
    tcp    LISTEN     0      511            127.0.0.1:18000                 *:*      users:(("redis-server",58282,7))
    tcp    LISTEN     0      511            127.0.0.1:18001                 *:*      users:(("redis-server",58286,7))
    tcp    LISTEN     0      511            127.0.0.1:18002                 *:*      users:(("redis-server",58290,7))
    tcp    LISTEN     0      511            127.0.0.1:18003                 *:*      users:(("redis-server",58292,7))
    tcp    LISTEN     0      511            127.0.0.1:18004                 *:*      users:(("redis-server",58412,7))
    tcp    LISTEN     0      511            127.0.0.1:18005                 *:*      users:(("redis-server",58389,7))

..

    创建集群

-  {redis_src_home}/src/redis-trib.rb create –replicas 1 127.0.0.1:8000
   127.0.0.1:8001 127.0.0.1:8002 127.0.0.1:8003 127.0.0.1:8004
   127.0.0.1:8005

-  给定 redis-trib.rb 程序的命令是 create ，
   这表示我们希望创建一个新的集群。
-  选项 –replicas 1 表示我们希望为集群中的每个主节点创建一个从节点。
-  之后跟着的其他参数则是实例的地址列表，
   我们希望程序使用这些地址所指示的实例来创建新集群。

.. code:: shell

    [root@web01 server]# cd redis
    [root@web01 redis]# src/redis-trib.rb create --replicas 1 127.0.0.1:8000 127.0.0.1:8001 127.0.0.1:8002 127.0.0.1:8003 127.0.0.1:8004 127.0.0.1:8005
    >>> Creating cluster
    >>> Performing hash slots allocation on 6 nodes...
    Using 3 masters:
    127.0.0.1:8000
    127.0.0.1:8001
    127.0.0.1:8002
    Adding replica 127.0.0.1:8003 to 127.0.0.1:8000
    Adding replica 127.0.0.1:8004 to 127.0.0.1:8001
    Adding replica 127.0.0.1:8005 to 127.0.0.1:8002
    M: efc84ca03f218f1e6e5b192d80d98c6ac1249b82 127.0.0.1:8000
       slots:0-5460 (5461 slots) master
    M: a119e29d2c0b10f8ad518b2f22a32ec6521b678c 127.0.0.1:8001
       slots:5461-10922 (5462 slots) master
    M: 8e15a9b6263360570c14cec4eac371274a797d8c 127.0.0.1:8002
       slots:10923-16383 (5461 slots) master
    S: f27567b23b4a2b359384fcfdac23d4506ce1e184 127.0.0.1:8003
       replicates efc84ca03f218f1e6e5b192d80d98c6ac1249b82
    S: ca0d6d326ee412c42cdf3a97837b949982f8d40c 127.0.0.1:8004
       replicates a119e29d2c0b10f8ad518b2f22a32ec6521b678c
    S: 84546ff6bf2e05b78a05db594143e23f5fbaa1e0 127.0.0.1:8005
       replicates 8e15a9b6263360570c14cec4eac371274a797d8c
    Can I set the above configuration? (type 'yes' to accept): yes
    >>> Nodes configuration updated
    >>> Assign a different config epoch to each node
    >>> Sending CLUSTER MEET messages to join the cluster
    Waiting for the cluster to join..
    >>> Performing Cluster Check (using node 127.0.0.1:8000)
    M: efc84ca03f218f1e6e5b192d80d98c6ac1249b82 127.0.0.1:8000
       slots:0-5460 (5461 slots) master
       1 additional replica(s)
    M: 8e15a9b6263360570c14cec4eac371274a797d8c 127.0.0.1:8002
       slots:10923-16383 (5461 slots) master
       1 additional replica(s)
    S: ca0d6d326ee412c42cdf3a97837b949982f8d40c 127.0.0.1:8004
       slots: (0 slots) slave
       replicates a119e29d2c0b10f8ad518b2f22a32ec6521b678c
    M: a119e29d2c0b10f8ad518b2f22a32ec6521b678c 127.0.0.1:8001
       slots:5461-10922 (5462 slots) master
       1 additional replica(s)
    S: f27567b23b4a2b359384fcfdac23d4506ce1e184 127.0.0.1:8003
       slots: (0 slots) slave
       replicates efc84ca03f218f1e6e5b192d80d98c6ac1249b82
    S: 84546ff6bf2e05b78a05db594143e23f5fbaa1e0 127.0.0.1:8005
       slots: (0 slots) slave
       replicates 8e15a9b6263360570c14cec4eac371274a797d8c
    [OK] All nodes agree about slots configuration.
    >>> Check for open slots...
    >>> Check slots coverage...
    [OK] All 16384 slots covered.

    [root@web01 redis]# redis-cli -p 8000 cluster nodes
    8e15a9b6263360570c14cec4eac371274a797d8c 127.0.0.1:8002 master - 0 1483089436276 3 connected 10923-16383
    efc84ca03f218f1e6e5b192d80d98c6ac1249b82 127.0.0.1:8000 myself,master - 0 0 1 connected 0-5460
    ca0d6d326ee412c42cdf3a97837b949982f8d40c 127.0.0.1:8004 slave a119e29d2c0b10f8ad518b2f22a32ec6521b678c 0 1483089435268 5 connected
    a119e29d2c0b10f8ad518b2f22a32ec6521b678c 127.0.0.1:8001 master - 0 1483089435772 2 connected 5461-10922
    f27567b23b4a2b359384fcfdac23d4506ce1e184 127.0.0.1:8003 slave efc84ca03f218f1e6e5b192d80d98c6ac1249b82 0 1483089434263 4 connected
    84546ff6bf2e05b78a05db594143e23f5fbaa1e0 127.0.0.1:8005 slave 8e15a9b6263360570c14cec4eac371274a797d8c 0 1483089435268 6 connected

..

    集群客户端操作

.. code:: shell

    redis-cli -c -p 8000

    set foo bar
    get foo

    重新分片  ## 操作危险，需要谨慎
    ./redis-trib.rb reshard 127.0.0.1:7000

集群管理
~~~~~~~~

.. code:: shell

    集群状态
        redis-cli -p 8000 cluster nodes | grep master
    故障转移
        redis-cli -p 8002 debug segfault
    查看状态
        redis-cli -p 8000 cluster nodes | grep master

    增加新的节点
        ./redis-trib.rb add-node 127.0.0.1:8006 127.0.0.1:8000
    变成某实例的从
        redis 127.0.0.1:8006> cluster replicate 3c3a0c74aae0b56170ccb03a76b60cfe7dc1912e
    删除一个节点
        redis-trib del-node ip:port '<node-id>'
    删除master节点之前首先要使用reshard移除master的全部slot,然后再删除当前节点

状态说明
~~~~~~~~

-  集群最近一次向节点发送 PING 命令之后， 过去了多长时间还没接到回复。
-  节点最近一次返回 PONG 回复的时间。
-  节点的配置纪元（configuration epoch）：详细信息请参考 Redis 集群规范
   。
-  本节点的网络连接情况：例如 connected 。
-  节点目前包含的槽：例如 127.0.0.1:7001 目前包含号码为 5960 至 10921
   的哈希槽。

Redis API
---------

PHP使用redis
~~~~~~~~~~~~

.. code:: shell

    tar zxvf 2.2.7.tar.gz
    cd phpredis-2.2.7
    /data/server/php/bin/phpize
    ./configure --with-php-config=/data/server/php/bin/php-config
    make && make install
    echo 'extension="redis.so"' >> /data/server/php/etc/php.ini
    service php-fpm restart
    service nginx restart

..

    连接代码

.. code:: php

    <?php
        //连接本地的 Redis 服务
       $redis = new Redis();
       $redis->connect('127.0.0.1', 6379);
       echo "Connection to server sucessfully";
             //查看服务是否运行
       echo "Server is running: " . $redis->ping();
    ?>

..

    字符串操作

.. code:: php

    <?php
       //连接本地的 Redis 服务
       $redis = new Redis();
       $redis->connect('127.0.0.1', 6379);
       echo "Connection to server sucessfully";
       //设置 redis 字符串数据
       $redis->set("tutorial-name", "Redis tutorial");
       // 获取存储的数据并输出
       echo "Stored string in redis:: " . $redis->get("tutorial-name");
    ?>

Python连接redis
~~~~~~~~~~~~~~~

.. code:: python

    pip install redis

    >>> import redis
    >>> r = redis.StrictRedis(host='localhost', port=6379, db=0)
    >>> r.set('foo', 'bar')
    True
    >>> r.get('foo')
    'bar'

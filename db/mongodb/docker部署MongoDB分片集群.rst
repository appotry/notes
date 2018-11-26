docker部署MongoDB分片集群.rst
=======================================

注意事项
----------------------------------------

1. 配置节点 需要部署集群
2. 权限问题，根据具体情况路由需要绑定IP，绑定所有，使用参数 ``--bind_ip_all``

使用docker部署MongoDB分片集群
----------------------------------------

MONGO_VERSION=4.0.4

1. 启动所有容器
2. 初始化分片副本集
3. 初始化配置副本集
4. 配置分片

配置副本集
~~~~~~~~~~~~~~~~~~~

.. code-block:: shell

    # 初始化 分片副本集1
    //连接到rs1_svr1
    mongo <宿主ip>:21117
    //配置副本集
    rs.initiate();
    rs.add("<宿主ip>:21217");
    rs.add("<宿主ip>:21317");
    rs.status();
    Fix hostname of primary.
    cfg = rs.conf();
    cfg.members[0].host = "<宿主ip>:21117";
    rs.reconfig(cfg);
    rs.status();
    //以上命令一个一个执行

    # 初始化 分片副本集2
    # 连接到rs2_svr1
    # 同上

    # 初始化 配置服务副本集
    # 连接到configsrv
    # 同上

配置分片
~~~~~~~~~~~~~~~~~~~

.. code-block:: shell

    登陆mongos

    添加分片

    sh.addShard("rs1/172.17.104.247:27020,172.17.104.247:27021")
    sh.addShard("rs2/172.17.104.247:27023,172.17.104.247:27024")
    sh.status();

Docker Compose
==============

Compose是定义和运行多容器Docker应用程序的工具.你可以使用Compose文件来定义你的应用服务.然后,使用单个命令,您可以从配置创建并启动所有服务.

Compose使用于开发,测试和分期环境以及CI工作流.

使用Compose基本上是如下三个流程:

1. 使用\ ``Dockerfile``\ 定义你的应用的环境,这样你可以在任何地方重新生成你的应用环境
2. 在\ ``docker-compose.yml``\ 文件中定义组成你应用的服务,以便于它们可以在孤立的环境中一起运行
3. 最后,执行\ ``docker compose``,Compose将启动并运行你的app

``docker-compose.yml``\ 示例:

.. code:: shell

    version: '3'
    services:
      web:
        build: .
        ports:
        - "5000:5000"
        volumes:
        - .:/code
        - logvolume01:/var/log
        links:
        - redis
      redis:
        image: redis
    volumes:
      logvolume01: {}

Compose有用于管理整个应用生命周期的命令

-  启动,停止和重新构建服务
-  查看运行服务的状态
-  输出运行服务的日志
-  运行一次性命令

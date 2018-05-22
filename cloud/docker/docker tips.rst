docker tips
===========

docker以root身份进入容器
------------------------

.. code:: shell

    docker exec -it -u root 62044c564952 bash

docker容器中文乱码, 修改容器编码
--------------------------------

``locale -a`` 查看容器语言环境

临时修改 ``LANG=C.UTF-8``

永久修改, 在Dockerfile添加一行内容

``ENV LANG C.UTF-8``

重新构建镜像即可

修改容器时区
------------

比如, 修改为\ ``Asia/Shanghai``

``/usr/share/zoneinfo/Asia/Shanghai`` 文件不存在则需要安装 ``tzdata``

.. code:: dockerfile

    # 根据实际系统, 调整命令, 安装之后清楚缓存
    RUN apt-get update && apt-get install tzdata cron && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    # 如果使用创建软链接的方式, 镜像构建的时候文件不存在的时候不会报错, 只有进入容器才能发现时区没有修改成功, 软链接无效
    RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
        echo 'Asia/Shanghai' >/etc/timezone

    # 使用cp, 文件不存在, 构建镜像的时候就会报错提示
    # cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

容器中使用定时任务
------------------

Dockerfile

.. code:: dockerfile

    RUN echo "定时任务"  > /var/spool/cron/crontabs/root && \
        touch /var/log/cron.log && \
        # 权限及属主
        chmod 600 /var/spool/cron/crontabs/root && \
        chown root:crontab /var/spool/cron/crontabs/root && \

此外, 需要保证cron一直运行, 可以使用\ ``supervisor``,
或者构建镜像的时候添加一行

``RUN cron # (未测试)``

定时任务中如果涉及到中文问题, 需要设置编码, 可以在执行命令之前,
修改一下编码 ``export LANG="C.UTF-8"``

使用docker部署TensorFlow Serving
================================

`GitHub
dockerfile <https://github.com/tensorflow/serving/tree/master/tensorflow_serving/tools/docker>`__

Dockerfile
----------

.. code:: dockerfile

    FROM ubuntu:16.04

    MAINTAINER Jeremiah Harmsen <jeremiah@google.com>

    ADD sources.list /etc/apt/sources.list

    RUN apt-get clean && \
        apt-get update && apt-get install -y \
            build-essential \
            curl \
            git \
            libfreetype6-dev \
            libpng12-dev \
            libzmq3-dev \
            mlocate \
            pkg-config \
            python-dev \
            python-numpy \
            python-pip \
            software-properties-common \
            swig \
            zip \
            zlib1g-dev \
            libcurl3-dev \
            openjdk-8-jdk\
            openjdk-8-jre-headless \
            wget \
            && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

    # Set up grpc

    RUN pip install mock grpcio

    # Set up Bazel. 使用apt-get安装, 不需要Bazel, 具体自行修改

    ENV BAZELRC /root/.bazelrc
    # Install the most recent bazel release.
    ENV BAZEL_VERSION 0.5.1
    WORKDIR /
    RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list && \
        curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add - && \
        apt-get update && apt-get install tensorflow-model-server

    # 程序没有使用, 不需要安装tensorflow-serving-api
    RUN pip install tensorflow-serving-api

    COPY boot.sh /usr/local/boot.sh
    # 没有如下脚本, 则自行删除
    COPY start.sh /usr/local/start.sh
    COPY stop.sh /usr/local/stop.sh

    RUN chmod +x /usr/local/boot.sh /usr/local/start.sh /usr/local/stop.sh

    ENTRYPOINT ["/usr/local/boot.sh"]

163源
-----

``sources.list``

.. code:: shell

    deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse

boot.sh
-------

该脚本可以写入\ ``tensorflow_model_server``\ 启动命令,
启动容器的时候将model映射到容器内.

如果不启动守护进程, 又不想容器退出, 可以使用死循环或者tail避免容器退出.

.. code:: shell

    #!/bin/bash
    while true
      do sleep 100 ;
    done

    # tail -f /dev/null

..

    **觉得添加脚本麻烦, 可以使用如下命令**

.. code:: shell

    docker run -d boxfish/tensorflow-serving-devel:1.0 /bin/bash -c "while true;do sleep 100; done"

docker镜像构建命令
------------------

.. code:: shell

    docker build --pull -t $USER/tensorflow-serving-devel:1.0 -f Dockerfile.devel .

导出镜像
--------

.. code:: shell

    docker save -o tensorflow-serving-devel.tar boxfish/tensorflow-serving-devel

导入镜像
--------

.. code:: shell

    docker load -i tensorflow-serving-devel.tar

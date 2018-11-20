docker
======

自动安装
------------

.. code-block:: shell

    # 阿里云镜像
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

手动安装
-----------

系统要求
~~~~~~~~~~~~~~

-  Ubuntu 14.04、16.04
-  Debian 7.7、8.0
-  CentOS 7.X
-  Fedora 20、21、22
-  OracleLinux 6、7

Ubuntu
~~~~~~~~~~~~

.... code-block:: shell

    sudo apt-get remove docker docker-engine docker.io

    sudo apt-get update

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
        
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    
    sudo apt-get update

    sudo apt-get install docker-ce

CentOS
~~~~~~~~~~~~~~~~~~~

.... code-block:: shell

    #!/bin/bash
    sudo yum remove -y docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-selinux \
                    docker-engine-selinux \
                    docker-engine

    sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2 epel-release

    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo

    sudo yum install -y docker-ce docker-compose

    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
    {
    "storage-driver": "overlay",
    "registry-mirrors": ["https://haha.mirror.aliyuncs.com"]
    }
    EOF
    sudo usermod -G docker $1 
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    sudo systemctl enable docker

安装后操作
~~~~~~~~~~

If you would like to use Docker as a non-root user, you should now
consider adding your user to the “docker” group with something like:

::

    sudo usermod -aG docker your-user

Remember that you will have to log out and back in for this to take
effect!

docker-compose
--------------

`GitHub-docker-compose <https://github.com/docker/compose/releases>`__

`docs-docker-compose <https://docs.docker.com/compose/install/>`__

由于GitHub的访问问题,Linux系统的Docker
Compose下载也不稳定,所以可以从阿里云镜像站下载

`阿里云docker-toolbox <http://mirrors.aliyun.com/docker-toolbox/>`__

下载对应系统即可

.. code:: shell

    wget http://mirrors.aliyun.com/docker-toolbox/linux/compose/1.10.0/docker-compose-Linux-x86_64
    cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    root@ubuntu47:~/src# docker-compose -v
    docker-compose version 1.10.0, build 4bd6f1a

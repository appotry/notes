Install Docker Compose
======================

`Install Docker Compose <https://docs.docker.com/compose/install/#install-compose>`_ 

Linux系统安装 ``docker-compose`` ::
    # 下载
    sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    # 添加执行权限
    sudo chmod +x /usr/local/bin/docker-compose
    $ docker-compose --version
    docker-compose version 1.22.0, build 1719ceb

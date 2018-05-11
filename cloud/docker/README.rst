docker
======

Docker is the world’s leading software container platform.

docker 安装
-----------

`参考docker
安装 <https://yangjinjie.github.io/notes/cloud/docker/docker%E5%AE%89%E8%A3%85.html>`__

linux使用代理上网
-----------------

.. code:: shell

    因为docker被墙，有时候访问不了，使用代理上网,可以使用shadowsock共享上网
    然后在~/.bashrc里添加,如果匿名代理无需user和password，直接地址和端口

        export http_proxy=http://username:password@proxyserver:port/

        使代理生效
        source ~/.bashrc

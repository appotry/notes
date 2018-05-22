使用registry镜像,搭建docker私有库
=================================

.. code:: shell

    docker pull registry
    docker run -d -p 5000:5000 -v $PWD/registry:/tmp/registry registry

访问私有仓库

.. code:: shell

    root@ubuntu66:~/data# curl 127.0.0.1:5000/v2
    <a href="/v2/">Moved Permanently</a>.

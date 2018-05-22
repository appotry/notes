ikev2-vpn-server
================

镜像

`gaomd/ikev2-vpn-server/ <https://hub.docker.com/r/gaomd/ikev2-vpn-server/>`__

`GitHub
ikev2-vpn-server <https://github.com/gaomd/docker-ikev2-vpn-server>`__

下载镜像

::

    docker pull gaomd/ikev2-vpn-server

启动IKEv2 VPN SERVER

::

    docker run --privileged -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp gaomd/ikev2-vpn-server:0.3.0

生成\ ``.mobileconfig``\ 配置文件

用于 ``IOS/macOS`` 直接安装

HOST可以写域名,或者IP

::

    docker run --privileged -i -t --rm --volumes-from ikev2-vpn-server -e "HOST=vpn1.example.com" gaomd/ikev2-vpn-server:0.3.0 generate-mobileconfig > ikev2-vpn.mobileconfig

安装配置文件即可使用

使用telnet模拟http请求
======================

利用telnet可以与服务器建立http连接,获取网页,实现浏览器的功能

对于需要对http header进行观察和测试的时候很方便

输入 telnet 域名 端口

::

    telnet 127.0.0.1 60000

输入\ ``GET / HTTP/1.0``,连续按两次回车

.. code:: shell

    ➜  ~ telnet 127.0.0.1 60000
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    GET / HTTP/1.0

就可以看到http response,包括header和body

.. figure:: http://oi480zo5x.bkt.clouddn.com/telnet-01.png
   :alt: telnet-01

   telnet-01

注意GET和HTTP必须大写.小写可能会造成连接失败

如果使HTTP1.1的话,还需要加上如下内容

``HOST:127.0.0.1``

**加HOST的原因,是因为很多网站采用的都是虚拟主机的形式,host用来区别于同一服务器的其他虚拟主机**

2次回车表示把request发出去,因为http request最后以空行来表示结束

.. code:: shell

    ➜  ~ telnet 127.0.0.1 60000
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    GET / HTTP/1.1
    HOST:127.0.0.1

.. figure:: http://oi480zo5x.bkt.clouddn.com/telnet-02.png
   :alt: telnet-02

   telnet-02

一些网站会屏蔽不是浏览器的\ ``http request``, 这时可以指定客户端

.. code:: shell

    GET / HTTP/1.1
    HOST:127.0.0.1
    User-Agent: Mozilla/5.0 (Linux; U; Android 4.1.2; zh-tw; GT-I9300 Build/JZO54K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30

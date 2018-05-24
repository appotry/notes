grep
====

范例
----

.. code:: bash

    [root@ centos ~]# ip a |grep -Po 'inet \K\S+'
    127.0.0.1/8
    10.0.0.52/24
    172.16.1.52/24

    [root@ centos ~]# ifconfig eth0|grep -Po '(?<=t addr:)\S+'
    10.0.0.52

    [root@ centos ~]# ifconfig eth0|grep -Po '[(\d).]+(?=\s+Bca)'
    10.0.0.52

    ifconfig eth0|grep -Po --color '\w:\K.*(?=  B)'

    [yjj@centos awk]$ echo axyzba123bcc456 | grep -oP 'x|(?<=a).*(?=b)'
    x
    123

零宽断言
--------

-  ``(?=)`` 向右
-  ``(?!)`` 向右不匹配
-  ``(?<=)`` 向左
-  ``(?<!)`` 向左不匹配
-  ``\K`` 向右匹配 不用指定长度

用于查找在某些内容(但并不包括这些内容)之前或之后的东西，也就是说它们像
``\b ^ $ \< \>`` 这样的锚定作用，这个位置应该满足一定的条件(即断言)

--------------

-  ``(?=exp)`` 也叫零宽度正预测先行断言

   -  它断言自身出现的位置的后面能匹配表达式exp。
   -  括号中可以不用固定长度

::

    比如grep -Po `\b\w+(?=ing\b)'，匹配以ing结尾的单词的前面部分(除了ing以外的部分)，如查找
    I'm singing while you’re dancing.

-  ``(?<=exp)`` 也叫零宽度正回顾后发断言

   -  它断言自身出现的位置的前面能匹配表达式exp。
   -  比如``(?<=\bre)\w\b``会匹配以re开头的单词的后半部分(除了re以外的部分)，
   -  例如在查找reading a book时，它匹配ading。
   -  括号中必须固定长度

.. code:: shell


    [root@centos ~]# echo '127.host =  10.0.0.6'
    host =  10.0.0.6

.. code:: shell

    echo ":  456,"   取出456

    (?<=abc).* 可以匹配 abcdefgabc 中的什么

    (?<=\s)\d+(?=\s)

        23w32
        131
        213

    echo "/etc/sysconfig/network-scripts/ifcfg-eth0"

断言用来声明一个应该为真的事实。正则表达式中只有当断言为真时才会继续进行匹配。

.. code:: shell

    echo "https://www.baidu.com/scxzcx"

    echo "https://www.baidu.com     /scxzcx"

    匹配
    /scxzcx


    echo "https://www.baidu.com/jin/db/scxzcx"|grep -P --color '(?<=[^/]/)[^/]+'
    https://www.baidu.com/jin/db/scxzcx

负向零宽
~~~~~~~~

负向零宽断言也有“先行”和“后发”两种

负向零宽后发断言 ``(?<!表达式)``

负向零宽先行断言 ``(?!表达式)``

如果我们只是想要确保某个字符没有出现，但并不想去匹配它时怎么办？例如，如果我们想查找这样的单词–它里面出现了字母q，但是q后面跟的不是字母u,我们可以尝试这样：

匹配q后面不是字母u的单词

.. code:: shell

    [root@centos grep_test]# echo -e "query\nqazfg\ndfaq tee"
    query
    qazfg
    dfaq tee


    [root@centos grep_test]# echo -e "query\nqazfg\ndfaq tee"|grep -Po '\b\w+q[^u]\w*\b'
    dfaq tee
    [root@centos grep_test]# echo -e "query\nqazfg\ndfaq tee"|grep -Po '\b\w*q[^u]\w*\b'
    qazfg
    dfaq tee

负向零宽断言能解决这样的问题，因为它只匹配一个位置，并不消费任何字符。，我们可以这样来解决这个问题：\ ``\b\w*q(?!u)\w*\b。``

零宽度负预测先行断言(?!exp)，断言此位置的后面不能匹配表达式exp。

例如

.. code:: shell

    \d{3}(?!\d)

    \b((?!abc)\w)+\b

    grep -Po '\d{3}(?!\d)' <<< "1234\n12345\n123abc"

    grep -Po '\d{3}(?=[a-z])' <<< "1234\n12345\n123abc"

-  ``(?<!exp)``,零宽度负回顾后发断言来断言此位置的前面不能匹配表达式exp：

   -  匹配前面不是exp的位置

因此匹配前面不是反斜杠的正则表达式应该这样写

.. code:: shell

    (?<!\\)\*

    (?<![a-z])\d{7}

    (?<=<(\w+)>).*(?=<\/\1>)

    (?<=\bre)\w+\b           查找reading a book时
    (?<=\s)\d+(?=\s)

    \d{3}(?!\d)              匹配三位数字，而且这三位数字的后面不能是数字
    \b((?!abc)\w)+\b         匹配不包含连续字符串abc的单词。
    (?<=<(\w+)>).*(?=<\/\1>)   匹配不包含属性的简单HTML标签内里的内容。

实例
~~~~

.. code:: shell

    [root@localhost ~]# echo '127.0.0.1 = localhost'|grep -Po '=\s\K.*'
    localhost

    [root@localhost ~]# grep -Po '(^[^ ]+).*\1' 123
    qujian --- qujian
    chiling --- achiling
    lihao  ---   alihao
    [root@localhost ~]# grep -Po '(^[^ ]+).*\1\w+' 123
    qujian --- qujian123
    chiling --- achiling999
    lihao  ---   alihao123

    [root@localhost ~]# ifconfig eth0|grep -Po --color '\w:\K.*(?=  B)'
    10.0.0.7

    [root@localhost ~]# cat 1
    127   127ip1
    abc  abc123
    baidu google123
    123 123sina
    [root@localhost ~]# grep -Po '(\w+)\s.*\1\w+' 1
    127   127ip1
    abc  abc123
    123 123sina
    [root@localhost ~]# grep -Po '(^[^ ]).*\1\w+' 1
    127   127ip1
    abc  abc123
    123 123sina
    [root@localhost ~]# grep -Po '(^.*)\s.*\1\w+' 1
    127   127ip1
    abc  abc123
    123 123sina

    He like his liker.
            He like his lover.
            She love her liker.
            She love her lover.
        1. 删除以上内容当中包含单词“l..e”前后一致的行；
        2. 将文件中“l..e”前后一致的行中，最后一个l..e词首的l换成大写L；

    [root@localhost ~]# grep -Po '<([Hh].>).*\1' 2
    <H1>welcome to my homepage</H1>
    <h2>welcome to my homepage</h2>
    <h3>welcome to my homepage</h3>
    [root@localhost ~]# cat 2
    <div>hello world</div>
    <H1>welcome to my homepage</H1>
    <div>hello world</div>
    <h2>welcome to my homepage</h2>
    <div>hello world</div>
    <h3>welcome to my homepage</h3>
    <div>hello world</div>

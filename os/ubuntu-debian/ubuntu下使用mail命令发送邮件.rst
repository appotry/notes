Ubuntu下使用mail命令发送邮件
============================

安装heirloom-mailx
------------------

mail命令在Ubuntu下是需要安装的

::

    sudo apt-get install heirloom-mailx

配置
----

修改如下文件

-  Ubuntu
   ``/etc/nail.rc或者/etc/s-nail.rc``,具体哪个文件,安装之后查看一下即可
-  CentOS ``/etc/mail.rc``

.. code:: shell

    #...
    set from=brave0517@163.com
    set smtp=smtp.163.com
    set smtp-auth-user=brave0517@163.com
    set smtp-auth-password=xxxx
    set smtp-auth=login
    set smtp-use-starttls
    set ssl-verify=ignore

配置完成之后就可以使用mail发送邮件了

使用mail
--------

1. 交互形式发送邮件

   mail + 邮箱地址,回车 -> 填写主题 -> 填写内容 -> ctrl + d 结束输入 ->
   cc代表抄送，回车完成发送

2. 使用管道发送

   echo “邮件内容” \| mail -s “主题” 邮箱地址

3. 读取文件发送

   mail -s “主题” “邮箱地址” < “path/filename”

有些敏感的内容,可能会被屏蔽,换内容继续尝试

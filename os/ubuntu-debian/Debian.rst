Debian
======

让Debian以root登录
------------------

.. code:: bash

    # 修改gdm3的登录pam文件
    # vi /etc/pam.d/gdm3
    # 将auth required pam_succeed_if.so user != root quiet_success注释掉 //本行前加#
    # 重启即可

让Debian以root自动登录。
------------------------

首先修改gdm3的设定文件

.. code:: bash

    # vi /etc/gdm3/deamon.conf
    AutomaticLogin = false //改为true
    AutomaticLogin = root //以root自动登录
    # 如果想等几秒再登录，那么用以下的
    TimedLoginEnable = true
    TimedLogin = root
    TimedLoginDelay = 5 //延迟5秒登录，可修改
    # 最后gdm3的自动登录pam文件
    # vi /etc/pam.d/gdm3-autologin
    # 将auth required pam_succeed_if.so user != root quiet_success注释掉。 #//在本行前加#，取消Debian不让root登录的限制。
    # s重启即可。

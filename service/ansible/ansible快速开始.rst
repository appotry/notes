Ansible快速开始
===============

sshpass
-------

.. code:: shell

    sshpass - noninteractive ssh password provider
    sshpass -p 123456 ssh -o StrictHostKeyChecking=no root@172.16.1.41 "hostname"

创建密钥对

.. code:: shell

    ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa >/dev/null 2>&1

sshpass非交互式工具使用

.. code:: shell

    sshpass -p 123456 ssh -o StrictHostKeyChecking=no root@172.16.1.41 "uptime"
    sshpass -p 123456 scp -o StrictHostKeyChecking=no /etc/hosts root@172.16.1.41:~

    # -p:指定ssh连接用户的密码
    # -o StrictHostKeyChecking=no 避免第一次登录出现公钥检查。

.. code:: shell

    # 非交互分发公钥
    sshpass -p111111 ssh-copy-id -i /root/.ssh/id_dsa.pub "-p50517 -o StrictHostKeyChecking=no 172.16.1.41"

fenfa_key.sh
~~~~~~~~~~~~

.. code:: shell

    # !/bin/bash

    for n in 41 31 8
    do
    sshpass -p111111 ssh-copy-id -i /root/.ssh/id_dsa.pub "-p50517 -o StrictHostKeyChecking=no 172.16.1.$n"
    done

key_provider.sh
~~~~~~~~~~~~~~~

.. code:: shell

    [root@manager scripts]# cat key_provider.sh

    # !/bin/bash

    [ ! -f ~/.ssh/id_dsa.pub ] && ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa >/dev/null 2>&1
    Port=52113

    for n in 41 31 8 51 7
    do
    sshpass -p111111 ssh-copy-id -i ~/.ssh/id_dsa.pub "-p$Port -o StrictHostKeyChecking=no 172.16.1.$n"
    done

基于ssh-copy-id 脚本原理 实现的 批量分发秘钥

.. code:: shell

    for n in 31 61 41 7 8
    do
     sshpass -p 123456 ssh -o StrictHostKeyChecking=no 172.16.1.$n "mkdir -m 700 -p ~/.ssh/"
     sshpass -p 123456 scp -o StrictHostKeyChecking=no ~/.ssh/id_dsa.pub     yjj@172.16.1.$n:~/.ssh/authorized_keys
     sshpass -p 123456 ssh -o StrictHostKeyChecking=no 172.16.1.$n "chmod 600 ~/.ssh/authorized_keys"
     /bin/ls -ld /home/yjj/.ssh
     /bin/ls -l /home/yjj/.ssh
    done

Ansible
-------

使用Ansible
~~~~~~~~~~~

python语言是运维人员必会的语言！

ansible是一个基于Python开发的自动化运维工具！其功能实现基于SSH远程连接服务！

ansible可以实现批量系统配置、批量软件部署、批量文件拷贝、批量运行命令等功能

-  http://docs.ansible.com/ansible/intro_installation.html
-  http://www.ansible.com.cn/
-  `http://docs.ansible.com/modules_by_category.html
   http://www.ansible.cn/docs/ <http://docs.ansible.com/modules_by_category.html%20http://www.ansible.cn/docs/>`__

特点

1. ``no agents``\ ：不需要在被管控主机上安装任何客户端；
2. ``no server``\ ：无服务器端，使用时直接运行命令即可；
3. ``modules in any languages``\ ：基于模块工作，可使用任意语言开发模块；
4. ``yaml``\ ，not code：使用yaml语言定制剧本playbook；
5. ``ssh by default``\ ：基于SSH工作；
6. ``strong multi-tier solution``\ ：可实现多级指挥。

配置文件

1. ansible 应用程序的主配置文件：\ ``/etc/ansible/ansible.cfg``
2. Host Inventory 定义管控主机 ：\ ``/etc/ansible/hosts``

.. code:: shell

    [root@db01 scritps]# ansible --version
    ansible 2.1.1.0
      config file = /etc/ansible/ansible.cfg
      configured module search path = Default w/o overrides
    添加控制组
    [root@db01 scritps]# vim /etc/ansible/hosts
    ## 表示把下面那些地址加入  yjj这个组
    [yjj]
    172.16.1.41
    172.16.1.31
    172.16.1.8
    172.16.1.7
    172.16.1.51

..

    修改端口

.. code:: shell

    [root@db01 scritps]# vim /etc/ansible/ansible.cfg
    ##

    #poll_interval  = 15
    #sudo_user      = root
    #ask_sudo_pass = True
    #ask_pass      = True
    #transport      = smart
    remote_port    = 52113
    #module_lang    = C
    #module_set_locale = True

..

    执行命令

.. code:: shell

    [root@db01 scritps]# ansible yjj -m command -a "hostname"

      -m MODULE_NAME, --module-name=MODULE_NAME
                            module name to execute (default=command)
      -a MODULE_ARGS, --args=MODULE_ARGS
                            module arguments

.. code:: shell

    [root@db01 scritps]# ansible yjj -m command -a "grep keepcache /etc/yum.conf"
    [root@db01 scritps]# ansible yjj -m command -a "sed -i 's#keepcache=0#keepcache=1#g' /etc/yum.conf"

查看帮助
~~~~~~~~

.. code:: shell

    [root@db01 scritps]# ansible-doc -h
    Usage: ansible-doc [options] [module...]

    Options:
      -h, --help            show this help message and exit
      -l, --list            List available modules
      -M MODULE_PATH, --module-path=MODULE_PATH
                            specify path(s) to module library (default=None)
      -s, --snippet         Show playbook snippet for specified module(s)
      -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                            connection debugging)
      --version             show program's version number and exit

Ansible模块
~~~~~~~~~~~

查看模块

.. code:: shell

    [root@manager scripts]# ansible-doc -l
    a10_server                         Manage A10 Networks AX/SoftAX/Thunder/vThunder d...
    a10_service_group                  Manage A10 Networks devices' service groups
    a10_virtual_server                 Manage A10 Networks devices' virtual servers
    acl                                Sets and retrieves file ACL information.
    add_host                           add a host (and alternatively a group) to the an...
    airbrake_deployment                Notify airbrake about app deployments
    alternatives                       Manages alternative programs for common commands
    apache2_module                     enables/disables a module of the Apache2 webserv...
    apk                                Manages apk packages
    ……

ping
^^^^

测试远程主机的运行状态

.. code:: shell

    [root@manager scripts]# ansible yjj -m ping
    172.16.1.7 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    172.16.1.41 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    172.16.1.8 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    172.16.1.31 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    172.16.1.51 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }

command
^^^^^^^

在远程主机上执行命令

相关选项如下：

-  creates：一个文件名，当该文件存在，则该命令不执行
-  free_form：要执行的linux指令
-  chdir：在执行指令之前，先切换到该目录
-  removes：一个文件名，当该文件不存在，则该选项不执行
-  executable：切换shell来执行指令，该执行路径必须是一个绝对路径

.. code:: shell

    [root@manager scripts]# ansible yjj -m command -a "uptime"
    172.16.1.7 | SUCCESS | rc=0 >>
     14:20:11 up  4:10,  2 users,  load average: 0.00, 0.00, 0.00

    172.16.1.8 | SUCCESS | rc=0 >>
     14:20:11 up 13:46,  5 users,  load average: 0.00, 0.00, 0.00

如果需要使用管道，可以使用shell模块。与command不同的是，此模块可以支持命令管道，同时还有另一个模块也具备此功能：raw

file
^^^^

设置文件的属性

相关选项如下

-  force：需要在两种情况下强制创建软链接，一种是源文件不存在，但之后会建立的情况下；另一种是目标软链接已存在，需要先取消之前的软链，然后创建新的软链，有两个选项：yes|no
-  group：定义文件/目录的属组
-  mode：定义文件/目录的权限
-  owner：定义文件/目录的属主
-  path：必选项，定义文件/目录的路径
-  recurse：递归设置文件的属性，只对目录有效
-  src：被链接的源文件路径，只应用于state=link的情况
-  dest：被链接到的路径，只应用于state=link的情况
-  state：

   -  directory：如果目录不存在，就创建目录
   -  file：即使文件不存在，也不会被创建
   -  link：创建软链接
   -  hard：创建硬链接
   -  touch：如果文件不存在，则会创建一个新的文件，如果文件或目录已存在，则更新其最后修改时间
   -  absent：删除目录、文件或者取消链接文件

.. code:: shell

    -a 'path=  mode=  owner= group= state={file|directory|link|hard|touch|absent}  src=(link，链接至何处)'

..

    示例

远程文件符号链接创建

.. code:: shell

    [root@manager scripts]# ansible yjj -m file -a "src=/etc/resolv.conf dest=/tmp/resolv.conf state=link"
    172.16.1.8 | SUCCESS => {
        "changed": true,
        "dest": "/tmp/resolv.conf",
        "gid": 0,
        "group": "root",
        "mode": "0777",
        "owner": "root",
        "size": 16,
        "src": "/etc/resolv.conf",
        "state": "link",
        "uid": 0
    }
    172.16.1.7 | SUCCESS => {
        "changed": true,
        "dest": "/tmp/resolv.conf",
        "gid": 0,
        "group": "root",
        "mode": "0777",
        "owner": "root",
        "size": 16,
        "src": "/etc/resolv.conf",
        "state": "link",
        "uid": 0
    }

远程文件符号链接删除

.. code:: shell

    [root@manager scripts]# ansible yjj -m command -a "ls -al /tmp/resolv.conf"
    172.16.1.7 | SUCCESS | rc=0 >>
    lrwxrwxrwx 1 root root 16 Oct 15 14:14 /tmp/resolv.conf -> /etc/resolv.conf

    172.16.1.8 | SUCCESS | rc=0 >>
    lrwxrwxrwx 1 root root 16 Oct 15 14:14 /tmp/resolv.conf -> /etc/resolv.conf

copy
^^^^

复制文件到远程主机

相关选项如下

-  backup：在覆盖之前，将源文件备份，备份文件包含时间信息。有两个选项：yes|no
-  content：用于替代“src”，可以直接设定指定文件的值
-  dest：必选项。要将源文件复制到的远程主机的绝对路径，如果源文件是一个目录，那么该路径也必须是个目录
-  directory_mode：递归设定目录的权限，默认为系统默认权限
-  force：如果目标主机包含该文件，但内容不同，如果设置为yes，则强制覆盖，如果为no，则只有当目标主机的目标位置不存在该文件时，才复制。默认为yes
-  others：所有的file模块里的选项都可以在这里使用
-  src：被复制到远程主机的本地文件，可以是绝对路径，也可以是相对路径。如果路径是一个目录，它将递归复制。在这种情况下，如果路径使用“/”来结尾，则只复制目录里的内容，如果没有使用“/”来结尾，则包含目录在内的整个内容全部复制，类似于rsync。

.. code:: shell

    [root@db01 scritps]# ansible yjj -m copy -a "src=/etc/passwd dest=/root/yjj.txt owner=root group=root mode=0755"
    172.16.1.31 | SUCCESS => {
        "changed": true,
        "checksum": "ca4c1e38e150b4de43a9a0fb13dc18e33d901d2e",
        "dest": "/root/yjj.txt",
        "gid": 0,
        "group": "root",
        "md5sum": "617c0932c7ac8c71de3dcffbb243cbdd",
        "mode": "0755",
        "owner": "root",
        "size": 1171,
        "src": "/root/.ansible/tmp/ansible-tmp-1476442649.82-254246058554780/source",
        "state": "file",
        "uid": 0
    }

..

    将本地文件“/etc/ansible/ansible.cfg”复制到远程服务器

.. code:: shell

    [root@manager scripts]# ansible yjj -m copy -a "src=/etc/ansible/ansible.cfg dest=/tmp/ansible.cfg owner=root group=root mode=0644"
    172.16.1.8 | SUCCESS => {
        "changed": true,
        "checksum": "d84066f339afd959b46f5d4775192d2fe6772edc",
        "dest": "/tmp/ansible.cfg",
        "gid": 0,
        "group": "root",
        "md5sum": "7565671ad8d7502d26b4e158a4e85c95",
        "mode": "0644",
        "owner": "root",
        "size": 13821,
        "src": "/root/.ansible/tmp/ansible-tmp-1476512336.97-153144333074174/source",
        "state": "file",
        "uid": 0
    }
    172.16.1.7 | SUCCESS => {
        "changed": true,
        "checksum": "d84066f339afd959b46f5d4775192d2fe6772edc",
        "dest": "/tmp/ansible.cfg",
        "gid": 0,
        "group": "root",
        "md5sum": "7565671ad8d7502d26b4e158a4e85c95",
        "mode": "0644",
        "owner": "root",
        "size": 13821,
        "src": "/root/.ansible/tmp/ansible-tmp-1476512336.94-250207092553974/source",
        "state": "file",
        "uid": 0
    }

shell
~~~~~

    切换到某个shell执行指定的指令，参数与command相同。

与command不同的是，此模块可以支持命令管道，同时还有另一个模块也具备此功能：raw

``-a 'command'`` 运行shell命令

.. code:: shell

    ansible all -m shell -a echo "123456789" |passwd --stdin user1'
    [root@manager scripts]#  ansible 172.16.1.31 -m shell -a 'useradd user1 && echo "123456789" |passwd --stdin user1'

cron
^^^^

定时任务管理

``-a  'name= state=  minute=  hour= day=  month=  weekday= job='``

.. code:: shell

    [root@manager scripts]#  ansible yjj -m cron -a 'name="time sync" state=present minute="*/5" job="/usr/sbin/ntpdate ntp1.aliyun.com >/dev/null 2>&1"'
    172.16.1.8 | SUCCESS => {
        "changed": true,
        "envs": [],
        "jobs": [
            "Time",
            "time sync"
        ]
    }
    172.16.1.7 | SUCCESS => {
        "changed": true,
        "envs": [],
        "jobs": [
            "Time",
            "time sync"
        ]
    }

..

    验证

.. code:: shell

    # Ansible: time sync

    */5 * * * * /usr/sbin/ntpdate ntp1.aliyun.com >/dev/null 2>&1

user
^^^^

    系统用户管理

.. code:: shell

    [root@manager scripts]#  ansible yjj -m user -a 'name=yjj shell=/bin/bash comment="wodege" uid=888'
    172.16.1.8 | SUCCESS => {
        "changed": true,
        "comment": "wodege",
        "createhome": true,
        "group": 888,
        "home": "/home/yjj",
        "name": "yjj",
        "shell": "/bin/bash",
        "state": "present",
        "system": false,
        "uid": 888
    }
    172.16.1.7 | SUCCESS => {
        "changed": true,
        "comment": "wodege",
        "createhome": true,
        "group": 888,
        "home": "/home/yjj",
        "name": "yjj",
        "shell": "/bin/bash",
        "state": "present",
        "system": false,
        "uid": 888
    }

    [root@web01 ~]# tail -1 /etc/passwd
    yjj:x:888:888:wodege:/home/yjj:/bin/bash

group
^^^^^

    系统用户组管理

template
^^^^^^^^

service
^^^^^^^

系统服务管理

.. code:: shell

    -a 'name= state={started|stopped|restarted} enabled=(是否开机自动启动)  runlevel='

    #state must be one of: running,started,stopped,restarted,reloaded,

.. code:: shell

    [root@manager scripts]# ansible yjj -m service -a 'name=crond state=started'
    172.16.1.7 | SUCCESS => {
        "changed": false,
        "name": "crond",
        "state": "started"
    }
    172.16.1.8 | SUCCESS => {
        "changed": false,
        "name": "crond",
        "state": "started"
    }

script
^^^^^^

The `script <#script>`__ module takes the script name followed by a list
of space-delimited arguments. The local script at path will be
transferred to the remote node and then executed. The given script will
be processed through the shell environment on the remote node. This
module does not require python on the remote system, much like the [raw]
module.

.. code:: shell

    远程执行  -a '/PATH/TO/SCRIPT' 运行脚本

    ansible all -m script -a '/tmp/a.sh'

    [root@db01 scritps]# ansible 172.16.1.31 -m script -a '/server/scritps/1.sh'

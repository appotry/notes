pip
===

`pip <https://pip.pypa.io/en/latest/>`__

安装
----

通过 ``get-pip.py`` 安装
~~~~~~~~~~~~~~~~~~~~~~~~

下载 ``get-pip.py``

.. code:: shell

    wget https://bootstrap.pypa.io/get-pip.py

    # 获取
    python get-pip.py
    python3 get-pip.py # 没有python命令,有其他版本的话使用该版本运行
    # 使用相应的python可以安装相应2，3的pip
    root@ubuntu-linux:~/src# pip -V
    pip 9.0.1 from /usr/local/lib/python3.5/dist-packages (python 3.5)

升级
~~~~

Linux or macOS:

.. code:: shell

    pip install -U pip

Windows:

.. code:: shell

    python -m pip install -U pip

快速开始
--------

先决条件: 安装 pip

从\ `PyPI <http://pypi.python.org/pypi/>`__\ 安装

.. code:: shell

    $ pip install SomePackage
      [...]
      Successfully installed SomePackage

指定文件安装

.. code:: shell

    $ pip install SomePackage-1.0-py2.py3-none-any.whl
      [...]
      Successfully installed SomePackage

指定版本安装

.. code:: shell

    pip install django==1.9
    # 升级为指定版本
    pip install -U urllib3==1.22

查看安装的文件

.. code:: shell

    pip show --files SomePackage

    示例
    # xlrd (1.0.0) - Latest: 1.1.0 [wheel]
    # xlwt (1.2.0) - Latest: 1.3.0 [wheel]

查看所有包版本, 当前版本, 最新版本

.. code:: shell

    pip list --outdated

升级包:

.. code:: shell

    $ pip install --upgrade SomePackage
      [...]
      Found existing installation: SomePackage 1.0
      Uninstalling SomePackage:
        Successfully uninstalled SomePackage
      Running setup.py install for SomePackage
      Successfully installed SomePackage

卸载包

.. code:: shell

    $ pip uninstall SomePackage
      Uninstalling SomePackage:
        /my/env/lib/pythonx.x/site-packages/somepackage
      Proceed (y/n)? y

pip使用过程中遇到的问题
-----------------------

MacOS OSError: [Errno 1] Operation not permitted
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

原因是Mac的内核保护,默认会锁定/system,/sbin,/usr目录

解决(不一定有用,没用可以关掉保护,百度…)

.. code:: shell

    pip install --upgrade pip
    sudo pip install numpy --upgrade --ignore-installed
    sudo pip install scipy --upgrade --ignore-installed
    sudo pip install scikit-learn --upgrade --ignore-installed

配置阿里云pip源
--------------------

配置文件位置::

    全局的位于 /etc/pip.conf
    用户级别的位于 $HOME/.pip/pip.conf
    每个 virtualenv 也可以有自己的配置文件 $VIRTUAL_ENV/pip.conf
    配置文件内容：

    [global]
    trusted-host=mirrors.aliyun.com
    index-url=http://mirrors.aliyun.com/pypi/simple

执行pip的时候，指定源:

.. code-block:: shell

    # pip版本太旧可能不支持 --trusted-host
    pip install --upgrade pip -i http://mirrors.aliyun.com/pypi/simple  --trusted-host mirrors.aliyun.com


cannot install ''numpy'.It is a distutils installed project and thus we cannot
--------------------------------------------------------------------------------------------------------------------------

强行安装高版本::

    pip install numpy --ignore-installed numpy

指定国内源
--------------------------------------------------------------------------------------------------------------------------

.. code-block:: shell

    mkdir ~/.pip 
    vim ~/.pip/pip.conf
    [global]
    index-url = http://mirrors.aliyun.com/pypi/simple/
    [install]
    trusted-host = mirrors.aliyun.com

    # pip国内镜像源。
    阿里云 http://mirrors.aliyun.com/pypi/simple/
    中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
    豆瓣 http://pypi.douban.com/simple
    Python官方 https://pypi.python.org/simple/
    v2ex http://pypi.v2ex.com/simple/
    中国科学院 http://pypi.mirrors.opencas.cn/simple/
    清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/

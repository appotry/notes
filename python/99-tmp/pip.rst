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

运行命令

::

    python get-pip.py
    python3 get-pip.py # 没有python命令,有其他版本的话使用该版本运行

.. code:: shell

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

protobuf
========

Protocol Buffers - Google’s data interchange format
https://developers.google.com/protocol-buffers/

`GitHub <https://github.com/google/protobuf>`__

安装
----

python
~~~~~~

https://github.com/google/protobuf/tree/master/python

获取 ``protobuf-python``

.. code:: shell

    wget https://github.com/google/protobuf/releases/download/v3.5.0/protobuf-python-3.5.0.tar.gz

1. python版本, 2.6或更高

   python -V

2. 当运行 ``setup.py`` 时, 会自动安装setuptools,
   如果想手动安装看\ `这个 <https://packaging.python.org/en/latest/installing.html#setup-for-installing-packages>`__

3. 构建 ``protoc`` 的C++代码, 或者安装二进制包. 如果安装的二进制包,
   确保更当前包版本一致.

   protoc –version

..

    OS X

没安装过, 可以使用如下指令安装

::

    brew install protobuf

4. 构建并运行测试

.. code:: shell

    python setup.py build
    python setup.py test

..

    使用 C++ 实现 , 需要先编译 ``libprotobuf.so``:

::

    cd .. && make

..

    OS X

如果使用Homebrew安装的Python, 需要确保其他版本的protobuf没有安装,
Homebrew 安装的 ``Python`` 搜索 ``libprotobuf.so`` 会在搜索
``../src/.libs.``\ 目录之前搜索 ``/usr/local/lib``

你可以不链接通过Homebrew安装的protobuf 或在编译之前安装\ ``libprotobuf``

::

    brew unlink protobuf

or

::

    cd .. && make install

..

    On other \*nix:

You must make libprotobuf.so dynamically available. You can either
install libprotobuf you built earlier, or set LD_LIBRARY_PATH:

::

    export LD_LIBRARY_PATH=../src/.libs

or

::

    cd .. && make install

To build the C++ implementation run:

::

    python setup.py build --cpp_implementation

Then run the tests like so:

::

    python setup.py test --cpp_implementation

5. 安装

   sudo python setup.py install

or:

.. code:: shell

    cd .. && make install
    python setup.py install --cpp_implementation

问题记录
--------

``python setup.py test`` , 依赖 ``six>=1.9``, 而系统已经安装 six 1.4.1

.. code:: shell

    sudo pip install six  --upgrade --ignore-installed six

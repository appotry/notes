Ubuntu安装jdk
=============

两种方法

Ubuntu通过PPA安装jdk
--------------------

`How to Install JAVA on Ubuntu & LinuxMint via
PPA <http://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa>`__

Installing Java 8 on Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, you need to add webupd8team Java PPA repository in your system
and install Oracle Java 8 using following a set of commands.

.. code:: shell

    $ sudo add-apt-repository ppa:webupd8team/java
    $ sudo apt-get update
    $ sudo apt-get install oracle-java8-installer

    jdk7
    sudo apt-get install oracle-java7-installer

    安装器会提示你同意 oracle 的服务条款,选择 ok
    然后选择yes 即可
    如果你懒,不想自己手动点击.也可以加入下面的这条命令,默认同意条款:

    JDK7 默认选择条款

         shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

    JDK8 默认选择条款

        echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

    接下会是等待(依个人网速定)

    如果你因为防火墙或者其他原因,导致installer 下载速度很慢,可以中断操作.然后下载好相应jdk的tar.gz 包,放在:
       /var/cache/oracle-jdk7-installer             (jdk7)
       /var/cache/oracle-jdk8-installer              (jdk8)
    下面,然后安装一次installer. installer 则会默认使用 你下载的tar.gz包

Verify Installed Java Version

After successfully installing oracle Java using above step verify
installed version using the following command.

.. code:: shell

    rahul@tecadmin:~$ java -version

    java version "1.8.0_121"
    Java(TM) SE Runtime Environment (build 1.8.0_121-b13)
    Java HotSpot(TM) 64-Bit Server VM (build 25.121-b13, mixed mode, sharing)

Configuring Java Environment

In Webupd8 PPA repository also providing a package to set environment
variables, Install this package using the following command.

.. code:: shell

    $ sudo apt-get install oracle-java8-set-default

设置系统默认jdk

JDk7

::

    sudo update-java-alternatives -s java-7-oracle

JDK8

::

    sudo update-java-alternatives -s java-8-oracle

如果即安装了jdk7,又安装了jdk8,要实现两者的切换,可以:

::

    jdk8 切换到jdk7
    sudo update-java-alternatives -s java-7-oracle

    jdk7 切换到jdk8
    sudo update-java-alternatives -s java-8-oracle

使用二进制包安装
----------------

下载

.. code:: shell

        wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
        mkdir /usr/lib/jvm -p
        tar xf jdk-8u101-linux-x64.tar.gz -C /usr/lib/jvm/
        ln -s /usr/lib/jvm/jdk1.8.0_101/ /usr/lib/jvm/jdk

修改环境变量

.. code:: shell

    sudo vim ~/.bashrc

    export JAVA_HOME=/usr/lib/jvm/jdk  ## 这里要注意目录要换成自己解压的jdk 目录
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH

使环境变量马上生效

::

    source ~/.bashrc

设置系统默认jdk 版本

.. code:: shell

    sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_60/bin/java 300
    sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_60/bin/javac 300
    sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0_60/bin/jar 300
    sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/jdk1.7.0_60/bin/javah 300
    sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.7.0_60/bin/javap 300

然后执行

.. code:: shell

    sudo update-alternatives --config java

    若是初次安装jdk,会有下面的提示

    There is only one alternative in link group java (providing /usr/bin/java):
    /usr/lib/jvm/jdk1.7.0_60/bin/java

    否者,选择合适的jdk

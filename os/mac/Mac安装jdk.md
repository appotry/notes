# Mac安装jdk

## 下载

[下载页面](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

![MacOS-jdk-02](http://oi480zo5x.bkt.clouddn.com/MacOS-jdk-02.jpg)

![MacOS-jdk](http://oi480zo5x.bkt.clouddn.com/MacOS-jdk.jpg)

## 配置环境变量(如需要)

编辑 `.bash_profile`文件,如果没有,则创建

```shell
# jdk安装目录
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
PATH=$JAVA_HOME/bin:$PATH:.
CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
export JAVA_HOME
export PATH
export CLASSPATH
```

生效

    source .bash_profile

查看版本

    java -version

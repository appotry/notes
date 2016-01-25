# 安装 TeamCity

## 使用Archive with bundled Tomcat (any platform)

[Previous Releases Downloads](https://confluence.jetbrains.com/display/TW/Previous+Releases+Downloads)

TeamCity采用了构建服务器和构建代理的概念。服务器负责管理和构建配置。实际的构建过程（编译、打包、部署等等）是由一个或多个代理执行的。

TeamCity需要JAVA环境,从 `TeamCity 10.0`开始, 依赖`Java 1.8 JDK`或更高,确保已经安装成功

    java -version

    echo $JAVA_HOME

```shell
cd /usr/local
wget https://download.jetbrains.com/teamcity/TeamCity-10.0.5.tar.gz
tar xf TeamCity-10.0.5.tar.gz
```

启动停止

```shell
cd /usr/local/Teamcity/bin
./runAll.sh start
./runAll.sh stop
```

Teamcity 的数据目录除了存在于安装目录，在用户的家目录又一个隐藏目录(/root/.BuildServer)也保存部分。Teamcity迁移时，将安装目录和这个隐藏目录一起拷贝到其它主机，就可以完全保留数据
/root/.BuildServer

## 使用Docker

镜像地址

[https://hub.docker.com/u/jetbrains/](https://hub.docker.com/u/jetbrains/)
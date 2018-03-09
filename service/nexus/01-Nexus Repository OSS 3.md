# Nexus Repository Manager

[Documentation Nexus Repository Manager 3.3](http://books.sonatype.com/nexus-book/reference3/index.html)

# 安装和运行

## 使用Docker运行

[Docker Hub Sonatype Nexus Repository Manager 3](https://hub.docker.com/r/sonatype/nexus3/)

启动

    docker run -d -p 8081:8081 --name nexus -v $PWD/nexus-data:/nexus-data sonatype/nexus3

三个环境变量可以控制 `JVM参数`

`JAVA_MAX_HEAP`, passed as -Xmx. Defaults to 1200m.

`JAVA_MIN_HEAP`, passed as -Xms. Defaults to 1200m.

`EXTRA_JAVA_OPTS`. Additional options can be passed to the JVM via this variable.

示例:

    docker run -d -p 8081:8081 --name nexus -e JAVA_MAX_HEAP=1500m -v $PWD/nexus-data:/nexus-data sonatype/nexus3

查看日志:

    使用 docker logs nexus # 查看日志

## 访问Nexus

浏览器访问 IP:8081

![nexus-01-access](http://oi480zo5x.bkt.clouddn.com/nexus-01-access.png)

默认用户 `admin` 密码 `admin123`

## 目录说明

### 安装目录

```shell
bash-4.2$ ls
LICENSE.txt NOTICE.txt # license,copyright信息
bin      # nexus启动脚本,以及启动相关的配置文件
deploy
etc      # 配置文件
lib      # 库文件
public   # 应用程序公共资源
system   # 构成应用程序的组件和插件
```

### 数据目录

```shell
bash-4.2$ ls /nexus-data/ -l
total 68
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:43 backup
drwxr-xr-x   3 nexus nexus  4096 Apr 14 03:43 blobs
drwxr-xr-x 250 nexus nexus 12288 Apr 14 03:43 cache            # 有关当前缓存的Karaf包的信息
drwxr-xr-x   9 nexus nexus  4096 Apr 14 03:43 db               # OrientDB数据库，
drwxr-xr-x   3 nexus nexus  4096 Apr 14 03:43 elasticsearch    # 当前配置的Elasticsearch状态。
drwxr-xr-x   3 nexus nexus  4096 Apr 14 03:43 etc
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:42 generated-bundles
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:43 health-check
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:42 instances
drwxr-xr-x   3 nexus nexus  4096 Apr 14 03:43 keystores
-rw-r--r--   1 nexus nexus    14 Apr 14 03:42 lock
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:43 log
drwxr-xr-x   2 nexus nexus  4096 Apr 14 03:43 orient
-rw-r--r--   1 nexus nexus     5 Apr 14 03:42 port
drwxr-xr-x   7 nexus nexus  4096 Apr 14 03:43 tmp
```

## 修改HTTP端口

[其他配置](http://books.sonatype.com/nexus-book/reference3/install.html#configure-runtime)

配置文件路径:

    $data-dir/etc/nexus.properties

    application-port=9081

# 使用web界面

点点点

# 配置

# 问题

## 启动容器的时候,异常退出

```shell
# 容器异常退出,如下操作发现,权限拒绝
# 原因,宿主机$PWD/nexus-data目录属主不对
root@ubuntu66:~/data# docker logs nexus
mkdir: cannot create directory '../sonatype-work/nexus3/log': Permission denied
mkdir: cannot create directory '../sonatype-work/nexus3/tmp': Permission denied
Java HotSpot(TM) 64-Bit Server VM warning: Cannot open file ../sonatype-work/nexus3/log/jvm.log due to No such file or directory

Warning:  Cannot open log file: ../sonatype-work/nexus3/log/jvm.log
Warning:  Forcing option -XX:LogFile=/tmp/jvm.log
Unable to update instance pid: Unable to create directory /nexus-data/instances
/nexus-data/log/karaf.log (No such file or directory)
Unable to update instance pid: Unable to create directory /nexus-data/instances
```

查看容器里用户,及id

```shell
root@ubuntu66:~/data# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
sonatype/nexus3     latest              c66e39c805c9        2 days ago          464 MB
tutum/mongodb       latest              64ca9521c703        14 months ago       503 MB
root@ubuntu66:~/data# docker run -ti --rm --entrypoint="/bin/bash" sonatype/nexus3 -c "whoami && id"
nexus
uid=200(nexus) gid=200(nexus) groups=200(nexus)
```

解决办法

宿主机:

    chown -R 200 nexus-data/ # 使用数字id,避免使用名字与容器里用户名不一致

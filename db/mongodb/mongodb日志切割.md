# mongodb 日志切割

每一次重启,日志也会重新生成

[mongodb Rotate Log Files](https://docs.mongodb.com/manual/tutorial/rotate-log-files/)

四种方法

1. Default Log Rotation Behavior
2. Log Rotation with --logRotate reopen
3. Syslog Log Rotation
4. Forcing a Log Rotation with SIGUSR1

## 第一种 Default Log Rotation Behavior

```shell
root@ubuntu66:~# mongo
MongoDB shell version v3.4.2
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.2
> use admin
switched to db admin
> db.auth("yang","yang")
1
> db.runCommand({logRotate : 1})
{ "ok" : 1 }
```

![mongodb-1](http://oi480zo5x.bkt.clouddn.com/mongodb-1.jpg)

## 第二种 Log Rotation with --logRotate reopen

## 第四种 Forcing a Log Rotation with SIGUSR1

切割脚本

```shell
root@ubuntu66:~# cat logrotate_mongo.sh
#!/bin/bash

pid=$(/bin/pidof /usr/bin/mongod)
for n in $pid
do
if [ "$n" ];then
    kill -SIGUSR1 $n
fi
done

exit
```

定时任务

```shell
59 23 * * * /bin/bash /data/logRotate/logrotate_mongo.sh
```
# Mongodb用户,角色,权限管理

## 概念

### 用户概念

Mongodb的用户是由 用户名+所属库名组成

例如:

    登录mongo  testdb1 ，创建用户testuser
    登录mongo  testdb2 ，创建用户testuser

那上面创建的用户分别是：testuser@testdb1，testuser@testdb2

在哪个库下面创建用户，这个用户就是哪个库的

### 角色概念

查看所有用户show roles

Mongodb的授权采用了角色授权的方法，每个角色包括一组权限。

Mongodb已经定义好了的角色叫内建角色，我们也可以自定义角色。

[Built-In Roles](https://docs.mongodb.com/manual/core/security-built-in-roles/)

Mongodb内建角色包括下面几类：

  xx |角色
 ---|---
 Database User Roles | read<br>readWrite
 Database Administration Roles | dbAdmin<br>dbOwner<br>userAdmin
 Cluster Administration Roles | clusterAdmin<br>clusterManager<br>clusterMonitor<br>hostManager
 Backup and Restoration Roles | backup<br>restore
 All-Database Roles(3.4) | readAnyDatabase<br>readWriteAnyDatabase<br>userAdminAnyDatabase<br>dbAdminAnyDatabase
 Superuser Roles | root<br>
 Internal Role | `__system`

[内置角色详细权限](https://docs.mongodb.com/manual/reference/built-in-roles/)

[__system相关官方文档：](http://docs.mongodb.org/manual/reference/built-in-roles/#__system)

 权限 | 说明
 ---|---
 read/readWrite | 读写库的权限
 dbAdmin | 某数据库管理权限
 userAdmin | 某数据库用户的管理权限，包括创建用户，授权的管理
 dbOwner | 某数据库的所有者，拥有该库的所有权限，包括readWrite，dbAdmin和userAdmin权限
readAnyDatabase | 对所有数据库中的collection可读，同时包含listDatabases权限
readWriteAnyDatabase | 对所有数据库中的collection可读且可写，同时包含listDatabases权限
userAdminAnyDatabase | 对所有数据库拥有userAdmin角色，同时包含listDatabases权限
dbAdminAnyDatabase | 对所有数据库拥有dbAdmin角色，同时包含listDatabases权限
root | 包含readWriteAnyDatabase, dbAdminAnyDatabase, userAdminAnyDatabase 和 clusterAdmin 等角色。 但不能访问system. 开头的collection(root does not include any access to collections that begin with the system. prefix.)

## 配置认证环境和认证登录

1. Mongodb默认不开启认证

启动mongodb之后,创建一个管理用户

    use admin
    db.createUser({user:'yang',pwd:'yang',roles:[{ "role" : "root", "db" : "admin" }]});

2. 关闭mongodb

    db.shutdownServer()

3. 启用mongodb授权认证

    1. 以--auth 启动mongod

    2. 旧版本在mongodb配置文件中加入auth=true,mongodb 3.x使用yaml语法,配置不一样,请参考`mongodb之yaml配置文件`

[配置参考](https://docs.mongodb.com/master/reference/configuration-options/#security-options)

第一次启用--auth时会出现：

```shell
2015-05-13T11:20:22.296+0800 I ACCESS [conn1] note: no users configured in admin.system.users, allowing localhost access

2015-05-13T11:20:22.297+0800 I ACCESS [conn1] Unauthorized not authorized on admin to execute command { getLog: “startupWarnings” }

2015-05-13T12:07:08.680+0800 I INDEX [conn1] build index on: admin.system.users properties: { v: 1, unique: true, key: { user: 1, db: 1 }, name: “user_1_db_1″, ns: “admin.system.users” }
```

即之前未定义过用户，所以mongod将允许本地直接访问

4. 启动Mongodb

    sudo service mongod start

5. 认证登录

连接的时候认证

    mongo ip:27017/admin -u yang -p

连接之后认证

    > use admin
    switched to db admin
    > db.auth('yang','yang')

## 用户授权详解

### 创建用户并授权

[创建用户](http://docs.mongodb.org/manual/reference/method/db.createUser/)

语法：db.createUser({user:"UserName",pwd:"Password",roles:[{role:"RoleName",db:"Target_DBName"}]})

创建用户有3项需要提供：用户名，密码，角色列表

创建用户示例

    > use admin
    switched to db admin
    > db.createUser(
    ... {
    ...   user: "yang",
    ...   pwd: "yang"
    ... ,
    ...   roles: [{role: "root",db: "admin"}]
    ... }
    ... )
    Successfully added user: {
        "user" : "yang",
        "roles" : [
            {
                "role" : "root",
                "db" : "admin"
            }
        ]
    }
    >

### 修改密码

    use test
    db.changeUserPassword('testuser','testPWD');

### 添加角色

    use test
    db.grantRolesToUser(  "testuser",  [    { role: "read",db:"admin"}  ] )

### 回收角色权限

    use test
    db.revokeRolesFromUser("testuser",[    { role: "read",db:"admin"}  ] )

### 删除用户

首先进入目标库：use test
db.dropUser("testuser")

## 注意事项

1、MongodbVOE版本太低，可能导致远程连接mongodb认证失败，建议升级版本或者更换其它GUI工具
2、远程连接Mongodb一定要把mongodb服务器的防火墙打开，否则连接不上
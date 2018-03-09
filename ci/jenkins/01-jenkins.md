# Jenkins

<extoc></extoc>

## 安装Jenkins

[Installing Jenkins](https://jenkins.io/doc/book/getting-started/installing/)

本文使用Docker方式使用Jenkins

### OS X

1. 使用包安装
2. 使用brew安装

* 下载 pkg 包 [http://mirrors.jenkins.io/osx/latest](http://mirrors.jenkins.io/windows/latest)
* 安装

使用brew安装

Install the latest release version

    brew install jenkins

Install the LTS version

    brew install jenkins-lts

### Docker

下载镜像

    docker pull jenkins

启动,宿主机$PWD/jenkins映射到容器里的/var/jenkins_home

容器8080端口映射到宿主机49001端口

    docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home --name jenkins jenkins

设置容器时区

    docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime:ro --name jenkins jenkins

如果容器获取到的仍然是容器默认的时区,则需要使用参数,`-e TZ="Asia/Shanghai"`

浏览器访问

[http://localhost:49001/](http://localhost:49001/)

### Windows

1. 下载包 [http://mirrors.jenkins.io/windows/latest](http://mirrors.jenkins.io/windows/latest)
2. 安装

### Ubuntu/Debian

```shell
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

## Docker启动

```shell
docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime:ro --name jenkins jenkins
```

## Setup Wizard

设置管理员及密码

浏览器访问 [http://localhost:49001/](http://localhost:49001/)

![jenkins-01-Getting-Started](http://oi480zo5x.bkt.clouddn.com/jenkins-01-Getting-Started.png)

密码在容器中 /var/jenkins_home/secrets/initialAdminPassword

```shell
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
649be62674884a85851261888c0df824
```

将密码复制到密码框,下一步 -> 使用推荐的插件(网络比较慢,可能会出现安装不上的情况,未安装成功的可以进入之后继续安装) -> 输入管理员信息,保存

![jenkins-02-Create-Admin-User](http://oi480zo5x.bkt.clouddn.com/jenkins-02-Create-Admin-User.png)

配置完成

![jenkins-03-Jenkins-is-ready](http://oi480zo5x.bkt.clouddn.com/jenkins-03-Jenkins-is-ready.png)

## 使用Jenkins

### 添加 Slave 节点(如有需要)

持续集成的环境应当尽量保持独立，当多个用户共用同一个 Jenkins Master 节点的时候，很容易因为一个成员改变了机器配置而对另一个构建造成影响。

所以，能用 Slave 做的事情尽量用 Slave 去做， 何况 Docker 里创建一个 Slave 是非常容易的事情。

![jenkins-04-Manage-Nodes](http://oi480zo5x.bkt.clouddn.com/jenkins-04-Manage-Nodes.png)

![jenkins-05-New-Node](http://oi480zo5x.bkt.clouddn.com/jenkins-05-New-Node.png)

![jenkins-06-Node-Name](http://oi480zo5x.bkt.clouddn.com/jenkins-06-Node-Name.png)

![jenkins-07-Node-2](http://oi480zo5x.bkt.clouddn.com/jenkins-07-Node-2.png)

![jenkins-08-Node-3](http://oi480zo5x.bkt.clouddn.com/jenkins-08-Node-3.png)

![jenkins-09-Node-4](http://oi480zo5x.bkt.clouddn.com/jenkins-09-Node-4.png)

-secret后面跟的随机密码很重要,下面一步只有 `secret` 和 `name` 都一致才能连接成功。

> 需要下载镜像 jenkinsci/jnlp-slave

```shell
docker run --link jenkins -d jenkinsci/jnlp-slave -url  http://jenkins:8080 ab96387cc533b8be663ccfc57fce9f0e41b11cd6b07f96941e2b51164832f610 slave01
```

启动容器后刷新 Jenkins 的节点列表， 很快 slave01 节点就变成可用的啦。

### 搭建Node.js环境

#### 通过Install from `nodejs.org`方式

* 选择版本(没用通过Extract `*.zip/*.tar.gz`方式之前,有可能出现没有版本可供选择的情况,可能是网络原因)
* 设置全局安装的包,比如 `gitbook-cli@2.3.0 gitbook@3.2.2`
* 保存

![jenkins-14-Install-from-nodejs](http://oi480zo5x.bkt.clouddn.com/jenkins-14-Install-from-nodejs.png)

#### 通过 Extract `*.zip/*.tar.gz` 方式

1. 安装和配置 NodeJS Plugin 管理多个版本的 Node.js
2. 新建 Pipeline 项目，验证 Node.js 安装

##### 安装配置 NodeJS Plugin

使用NodeJS Plugin插件来安装Node.js

[NodeJS Plugin](https://wiki.jenkins-ci.org/display/JENKINS/NodeJS+Plugin)

插件管理中,安装 `NodeJS Plugin` 插件

`Manage Jenkins` -> `Manage Plugins` -> `Available` -> `NodeJS Plugin` -> `Install  without restart`

`Manage Jenkins` -> `Global Tool Configuration` -> `NodeJS`

![jenkins-10-NodeJS-01](http://oi480zo5x.bkt.clouddn.com/jenkins-10-NodeJS-01.png)

`http://npm.taobao.org/mirrors/node/v7.8.0/node-v7.8.0-linux-x64.tar.gz`

NodeJS所有版本: [http://npm.taobao.org/mirrors/node/](http://npm.taobao.org/mirrors/node/)

使用 `NodeJS Plugin` 来安装Node.js的好处

有这样几个好处：

* 和 Jenkins 集成得最好，新添加的 Slave 节点会自动安装 Node.js 依赖
* 避免了登录到 Slave 安装 Node.js 可能改变操作系统配置的问题
* 可以在不同的构建里使用不同的 Node.js 版本

##### 新建 Pipeline 项目

`New Item` -> `Enter an item name` -> `Pipeline` -> `OK`

配置 `Pipeline demo`

![jenkins-11-Pipeline-demo](http://oi480zo5x.bkt.clouddn.com/jenkins-11-Pipeline-demo.png)

代码内容(如果不安装GitBook,可以删除后面两个状态)

```node
node ('master') {
   stage '安装 Node'
   tool name: 'v7.8.0', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
   env.PATH = "${tool 'v7.8.0'}/node-v7.8.0-linux-x64/bin:${env.PATH}"
   stage '验证 Node'
   sh "node -v"
   sh "npm -v"
   stage '安装 GitBook'
   sh "npm install gitbook-cli gitbook -g"
   stage '验证 GitBook'
   sh "gitbook -V"
}
```

**后面构建如果报错,命令不存在的话,可以在构建执行的命令里面,添加环境变量**

    node ('master')

表示选中具有`master`标签的节点,如果有slave,配置的标签带有 `node` ,并且配置为
    node ('node'),那这些slave都会被选中

    tool name: 'v7.8.0', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'

表示构建的过程会用到之前配置的 `Node.js` 工具的 `v7.8.0` 版本

    env.PATH = "${tool 'v7.8.0'}/node-v7.8.0-linux-x64/bin:${env.PATH}"

上面这行会修改构建的`PATH`,否则会提示找不到`node`和`npm`命令

点击`保存`,然后`立即构建`,等待完成.`Node.JS`环境就搭建成功

![jenkins-12-demo-status](http://oi480zo5x.bkt.clouddn.com/jenkins-12-demo-status.png)

![jenkins-13-demo-console-output](http://oi480zo5x.bkt.clouddn.com/jenkins-13-demo-console-output.png)

## 常用插件

EnvInject 环境变量
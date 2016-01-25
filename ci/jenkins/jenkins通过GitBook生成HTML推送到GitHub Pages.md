# jenkins通过GitBook生成HTML推送到GitHub Pages

1. 从coding等**私有仓库**拉取md文件
2. 生成HTML
3. 发布到GitHub Pages

## jenkins配置

* 搭建Node.js环境
* 创建,配置自由风格项目

`New Item` -> `Enter an item name -- Freestyle project`

配置内容:

### Project name

配置项目名称

### Source Code Management

![jenkins-15-SCM](http://oi480zo5x.bkt.clouddn.com/jenkins-15-SCM.png)

### Build Triggers

由于在本机使用的Jenkins,没有公网IP,所以使用如下触发器

表示每五分钟检查SCM是否有新的变更,如果有则构建,没有不构建

![jenkins-16-Build-Triggers](http://oi480zo5x.bkt.clouddn.com/jenkins-16-Build-Triggers.png)

### Build Environment

由于上面配置的`Provide Node & npm bin/ folder to PATH`构建的时候发现,环境变量有问题,所以下面构建时执行的命令有配置node的环境变量,其中`NODEJS`为配置全局变量(`/var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/v7.8.0/bin/`)

**Manage Jenkins -> Configure System**

![jenkins-19-nodejs-env](http://oi480zo5x.bkt.clouddn.com/jenkins-19-nodejs-env.png)

继续配置构建环境

![jenkins-17-Build-Environment](http://oi480zo5x.bkt.clouddn.com/jenkins-17-Build-Environment.png)

### Build

```shell
export PATH=${NODEJS}:$PATH
bash summary_create.sh
sed -i "s#Updated: 2017-[0-9][0-9]-[0-9][0-9]#Updated: $(date +%F)#g" README.md
sed -ri 's#(\S+* \[)[0-9]+-(.*$)#\1\2#g' SUMMARY.md
cd python && bash summary_create.sh && sed -ri 's#(\S+* \[)[0-9]+-(.*$)#\1\2#g' SUMMARY.md && cd ..
gitbook build .
```

### Next

使用一个项目即可,构建时执行的脚本需要修改,这里使用下面的项目将HTML提交到GitHub Pages

为了避免麻烦,先将GitHub Pages仓库克隆到宿主机映射到容器里面的目录比如: jenkins/workspace下,而后将该仓库名目录下的文件拷贝到jenkins项目工作目录下(最好先测试手动能够推送)

**注意**

`Project name` -> gitbook-github
`Source Code Management` -> None
`Build Triggers` -> Build after other projects are built(Projects to watch note_gitbook)(Trigger only if build is stable)

* 必须要配置user.email,user.name
* 使用ssh的方式推送代码,私钥放置于宿主机映射目录下的.ssh目录下,公钥配置到GitHub Pages仓库下,并允许该`ssh key`推送.
* 在宿主机将项目克隆到宿主机映射目录下的jenkins工作目录下,并配置相关信息

配置参考

```shell
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[remote "origin"]
    url = 仓库地址 # 使用ssh key方式
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[user]
    name = xxx  # 用户
    email = xx@xx.com # 邮箱
[push]
    default = matching
```

`Build` ->

![jenkins-20-Build-2](http://oi480zo5x.bkt.clouddn.com/jenkins-20-Build-2.png)

```shell
/bin/cp -r /var/jenkins_home/workspace/note_gitbook/_book/* .
rm -rf assets && rm -rf _other
#git config user.email "xxx@qq.com"
#git config user.name "xx"
#git config push.default matching
git add .
git commit -m "Site updated: $(date +%F-%H-%M)"
git push origin master
```

## 附:docker-compose

```shell
➜  cat docker-compose.yml
jenkins-xxx:
  image: 'jenkins:latest'
  restart: always
  environment:
    - TZ=Asia/Shanghai
  volumes:
    - $PWD/jenkins:/var/jenkins_home
    - /etc/localtime:/etc/localtime:ro
  ports:
    - '49001:8080'
```

## 手动安装NodeJS

如果使用上面自动安装NodeJS的方式, 最后还是提示gitbook命令不存在

可以使用`root`身份进入容器, 创建软链接

docker以root身份进入容器

```shell
docker exec -it -u root 62044c564952 bash
```

或者直接全局安装`npm`, `gitbook`等命令

那样项目就不需要选择NodeJS了

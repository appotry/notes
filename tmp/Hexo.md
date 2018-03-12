# Hexo

[官方网址](https://hexo.io/docs/)

Hexo is a fast, simple and powerful blog framework. You write posts in Markdown (or other languages) and Hexo generates static files with a beautiful theme in seconds.

## 先决条件

依赖

* Node.js
* Git

### Install Git

[Git](https://git-scm.com/)

```shell
Linux (Ubuntu, Debian): sudo apt-get install git-core
Linux (Fedora, Red Hat, CentOS): sudo yum install git-core -y
# MacOS 可以使用brew安装git
# Windows直接下载安装包安装
```

### Install Node.js

[NodeJS](https://nodejs.org/en/)

The best way to install Node.js is with nvm.

```shell
cURL:
$ curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh

Wget:
$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh

Once nvm is installed, restart the terminal and run the following command to install Node.js.
$ nvm install stable

# 或者直接使用如下命令
sudo yum install npm -y

# Windows直接下载安装包安装
```

## 安装

Windows使用Git Bash执行下列相关命令

```shell
npm install hexo-cli -g
```

## 使用Hexo

### 查看帮助

```shell
# 执行命令 hexo help

hexo --help
Usage: hexo <command>

Commands:
  help     Get help on a command.
  init     Create a new Hexo folder.
  version  Display version information.

Global Options:
  --config  Specify config file instead of using _config.yml
  --cwd     Specify the CWD
  --debug   Display all verbose messages in the terminal
  --draft   Display draft posts
  --safe    Disable all plugins and scripts
  --silent  Hide output on console

For more help, you can use 'hexo help [command]' for the detailed information
or you can check the docs: http://hexo.io/docs/
```

```shell
hexo new "postName" #新建文章
hexo new page "pageName" #新建页面
hexo generate #生成静态页面至public目录
hexo server #开启预览访问端口（默认端口4000，'ctrl + c'关闭server）
hexo deploy #将.deploy目录部署到GitHub
hexo help  #查看帮助
hexo version  #查看Hexo的版本
```

### 快速开始

```shell
# 在当前目录创建blog目录, 并将其初始化为hexo 仓库
hexo init blog
cd blog
# hexo generate的简写, 会显示大量信息. 这个过程会生成大量博客相关的文件(css, js, html等)
hexo g
# 本地预览
hexo server
```

显示如下信息

```shell
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/. Press Ctrl+C to stop.
```

浏览器访问 [http://localhost:4000/](http://localhost:4000/)

以上就是Hexo使用默认主题, 在本地预览的情况,生成的内容在`public`目录下, 该目录有整个静态站点需要的内容.

## Hexo配置

### 配置文件

hexo仓库下 `_config.yml` 文件

### 修改主题

[https://hexo.io/docs/themes.html](https://hexo.io/docs/themes.html)

#### 使用Next主题

[hexo-theme-next](https://github.com/iissnan/hexo-theme-next)

作者github上有主题详细信息, 具体请看上述链接

在hexo初始化的blog仓库里面执行如下命令

```shell
git clone --branch v5.1.2 https://github.com/iissnan/hexo-theme-next themes/next
```

修改主题为next, 文件 `_config.yml`

    theme: next

#### Maupassant主题——大道至简

[github地址](https://github.com/tufu9441/maupassant-hexo)

```shell
$ git clone https://github.com/tufu9441/maupassant-hexo.git themes/maupassant
$ npm install hexo-renderer-jade --save
$ npm install hexo-renderer-sass --save

# 若安装报错，请使用淘宝NPM镜像进行安装

npm install hexo-renderer-sass --save  报错的话：
[root@hexo blog]# npm uninstall node-sass
[root@hexo blog]# npm install node-sass@latest
```

## Deployment

[https://hexo.io/docs/deployment.html](https://hexo.io/docs/deployment.html)

### 部署到GitHub Pages

1. 注册GitHub账号
2. 新建仓库, 命名为`username.github.io`, username为用户名
3. 使用ssh方式(需要配置公钥), 或者https方式(部署的时候会提示输入用户名及密码)

#### 安装部署插件

```shell
npm install hexo-deployer-git --save
```

#### 修改设置

```shell
Edit settings.

deploy:
  type: git
  repo: <repository url>
  branch: [branch]
  message: [message]
```

Option | Description
-------|------------
repo | `GitHub/Bitbucket/Coding/GitLab repository` URL
branch | Branch name. The deployer will detect the branch automatically if you are using GitHub or GitCafe.
message | Customize commit message (默认消息为 `Update Site: YYYY-MM-DD HH:mm:ss` , 内容为当前时间)

#### 部署

```shell
hexo clean
hexo g -d
# 或者
# hexo d -g
```

## 使用七牛云搭建博客

    利用七牛云搭建Hexo博客
    Hexo全静态，所以可以使用七牛融合CDN通过以下方式搭建博客

    1. 购买域名
    2. 将域名通过CNAME解析到七牛提供的域名
    3. 使用七牛云提供的开发者工具qrsbox，将博客内容同步到对象存储

### 使用 qrsbox  完整同步

删除该目录下日志文件
C:\Users\Administrator\.qrsbox

可以通过everything搜索 qrsbox查找该目录

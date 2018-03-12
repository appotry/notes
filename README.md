# Notes

> Updated: 2018-01-26

[![Build Status](https://travis-ci.org/yangjinjie/notes.svg?branch=master)](https://travis-ci.org/yangjinjie/notes)

- [目录](https://yangjinjie.github.io/notes/SUMMARY.html)
- [GitHub地址](https://github.com/yangjinjie/notes)
- [Github Pages方式访问](https://yangjinjie.github.io/notes/)
- [Read the Docs 方式](https://notes-by-yangjinjie.readthedocs.io)

> 域名 [https://yangjinjie.github.io](https://yangjinjie.github.io) 跳转到 [https://docs.yangjinjie.xyz](https://docs.yangjinjie.xyz)

## 离线阅读(推荐)

### 通过docker

```shell
git clone --depth=1 -b gh-pages https://github.com/yangjinjie/notes.git notes_notes
cd notes_notes
# 第一次会自动pull镜像, 之后就不需要了
docker-compose up -d
```

浏览器访问 [http://localhost:50500](http://localhost:50500)

获取最新内容, 需要到上述 `notes_notes` 目录, 运行如下命令(或者重新执行上述内容)

### 通过GitBook

可以使用`GitBook`本地预览,具体步骤:

* 克隆主分支
* 执行项目根目录下的目录生成脚本`summary_create.sh`
* 在项目目录下执行 `gitbook serve .` (插件需要先运行`gitbook install`安装)
* 使用浏览器访问 [http://localhost:4000](http://localhost:4000)

```shell
git clone --depth=1 https://github.com/yangjinjie/notes.git
bash summary_create.sh
gitbook install
gitbook serve .
```

[GitBook相关教程](tools/git/GitBook.md)

## 项目简介

可以使用搜索功能, Python相关内容, 需要进入侧边工具栏`Python`下搜索...

所有内容可在`GitHub notes`仓库中搜索

```shell
tree
.
notes
├── bigdata
├── ci
│   ├── TeamCity
│   └── jenkins
├── cloud
│   ├── docker
│   ├── kvm
│   └── openstack
├── db
│   ├── ~~~
│   └── ...
├── html,css,JavaScript
├── microservice
│   └── consul
├── network
├── os
│   ├── 各系统相关
│   └── ...
├── python
├── ruby
├── service
│   ├── 各类服务
│   └── ...
├── shell
├── tips
├── tmp
│   └── 未分类
└── tools
    ├── 各类工具, 比如vim,git
    └── ...
```

## SUMMARY.md 文件生成脚本

请查看项目下 `summary_create.sh`(适用于Mac,Linux)

    使用方法: 项目下执行 bash summary_create.sh

## 规范

* 每个目录下均创建`README.md`文件,说明该目录(同时也是使用脚本创建目录的需要)
* 文件命名规则 `[0-9][0-9]-文件名.md` , 便于排序
* 资源文件存放于`assets`下的对应目录下,命名规则: 名字-序号-说明,例如`jenkins-01-install.jpg`

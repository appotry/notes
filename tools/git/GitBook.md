# GitBook 入门

- [GitBook帮助中心](https://help.gitbook.com/)
- [Toolchain](https://toolchain.gitbook.com/)

## 安装

### 安装 Node.js

[下载地址](https://nodejs.org/zh-cn/)

或者

    Mac
    wget https://nodejs.org/dist/v7.8.0/node-v7.8.0.pkg

### 安装 GitBook

首先需要安装Node.js,然后使用npm安装gitbook

```shell
# 安装
npm install gitbook-cli -g

# 检查
gitbook -V
```

### gitbook help

```shell
# 获取帮助信息
$ gitbook help
```

## GitBook使用

Gitbook有几个主要的文件

### README.md

这个文件相当于一本Gitbook的简介，最上层(和`SUMMARY.md`文件同级)的`README.md`文件最终会被用于生成本书的`Introduction`。

### SUMMARY.MD

该文件是书的目录结构,使用Markdown语法,这个文件在使用gitbook命令行工具之前要先写好,以便生成书籍目录.

### gitbook editor

gitbook editor 实际上就是一个本地应用版的在线编辑器，使用方式和 gitbook在线编辑器类似，而这里的目录及章节是使用编辑器添加生成，同时也会存放到本地之前建立的目录.

## 导出图书

目前为止，Gitbook支持如下格式输出：

* 静态HTML，可以看作一个静态网站
* PDF格式
* eBook格式
* 单个HTML文件
* JSON格式

### 输出为HTML

```shell
➜  ops-book git:(master) ls
BOXFISH.md   Docker       README.md    VPN          book.json    nexus.md     内部
CI           ELK          SUMMARY.md   assets       nexus        node_modules 监控
```

#### 本地预览(会自动生成)

```shell
➜  ops-book git:(master) gitbook serve .
Live reload server started on port: 35729
Press CTRL+C to quit ...

info: 9 plugins are installed
info: 8 explicitly listed
info: loading plugin "toggle-chapters"... OK
info: loading plugin "splitter"... OK
info: loading plugin "livereload"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 81 pages
info: found 47 asset files
info: >> generation finished with success in 15.4s !

Starting server ...
Serving book on http://localhost:4000
```

可以在浏览器中打开这个网址：[http://localhost:4000](http://localhost:4000)

此时目录下面会多出一个 `_book` 目录,这个目录就是就是生成的静态网站内容.

#### 使用build参数生成到指定目录

在图书目录的上层目录使用如下命令生成

```shell
➜  notes gitbook build ops-book out_book # ops-book为项目目录名 静态网页将生成在out_book目录下
info: 9 plugins are installed
info: 7 explicitly listed
info: loading plugin "toggle-chapters"... OK
info: loading plugin "splitter"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 81 pages
info: found 47 asset files
info: >> generation finished with success in 17.7s !
```

### 生成 eBooks 和 PDFs

```shell
$ gitbook pdf ./ ./mybook.pdf

# Generate an ePub file
$ gitbook epub ./ ./mybook.epub

# Generate a Mobi file
$ gitbook mobi ./ ./mybook.mobi
```

#### 安装 ebook-convert

生成 ebooks (epub, mobi, pdf) 依赖 `ebook-convert`.

> GNU/Linux

安装 `Calibre`.

    sudo aptitude install calibre

在一些 GNU/Linux 发行版 `node` 被安装的名字为 `nodejs`, 手动创建软链接:

    sudo ln -s /usr/bin/nodejs /usr/bin/node

> OS X

下载 [Calibre application](https://calibre-ebook.com/download). 安装后创建软链接:

    sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/bin

`/usr/bin`可以修改为任何在环境变量里面的路径.

#### Covers

Covers are used for all the ebook formats. You can either provide one yourself, or generate one using the [autocover plugin](https://plugins.gitbook.com/plugin/autocover).

#### 输出PDF

由于生成pdf epub mobi等文件依赖于ebook-convert，故首先下载安装 Calibre

[下载链接](http://calibre-ebook.com/download)

这一步有一个关键地方：和windows一样要声明环境变量，否则还是会报ebook-convert......

mac的方式是：

    sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin

也有另外一种：Mac下该工具已包含在安装包中，用户在使用前请执行

```shell
export PATH="$PATH:/Applications/calibre.app/Contents/MacOS/" # 将cli tools路径加入系统路径，或将此句加入.bashrc。

export PATH=/Applications/calibre.app/Contents/MacOS:$PATH
➜ ~ echo $PATH
```

```shell
gitbook pdf gitbook ./gitbook入门教程.pdf

然后，你会发现你的目录里多了一个名为gitbook入门教程.pdf的文件，就是它了！
```

# GitBook 进阶

## 个性化配置

除了修改书籍的主题外，还可以通过配置 book.json 文件来修改 gitbook 在编译书籍时的行为，例如：修改书籍的名称，显示效果等等。

gitbook 在编译书籍的时候会读取书籍源码顶层目录中的 book.js 或者 book.json

[gitbook 文档](https://github.com/GitbookIO/gitbook)

## book.json 配置示例

```json
{
    "author": "Yang",
    "description": "notes",
    "extension": null,
    "generator": "site",
    "links": {
        "sharing": {
            "all": null,
            "facebook": null,
            "google": null,
            "twitter": null,
            "weibo": null
        },
        "sidebar": {
            "notes": "https://yangjinjie.github.io"
        }
    },
    "pdf": {
        "fontSize": 18,
        "footerTemplate": null,
        "headerTemplate": null,
        "margin": {
            "bottom": 36,
            "left": 62,
            "right": 62,
            "top": 36
        },
        "pageNumbers": false,
        "paperSize": "a4"
    },
    "plugins": [
        "toggle-chapters",
        "theme-comscore",
        "splitter",
        "-sharing",
        "search"
    ],
    "title": "notes",
    "variables": {}
}
```

## 插件

gitbook 支持许多插件，用户可以从 [NPM](https://www.npmjs.com/) 上搜索 gitbook 的插件，gitbook 文档 推荐插件的命名方式为：

* gitbook-plugin-X: 插件
* gitbook-theme-X: 主题

GitBook默认带有6个插件：

* font-settings
* highlight
* lunr
* search
* sharing
* theme-default

去除自带插件， 可在插件名前加-

    "plugins": [
        "-search"
    ]

### 插件安装方法

方法一:

1. 配置book.json 下的 plugins
2. 然后执行命令 gitbook install(自动安装插件)

```json
    "plugins": [
        "toggle-chapters",
        "theme-comscore",
        "splitter",
        "-sharing",
        "search"
    ],
```

完整配置请查看

[book.json 配置示例](#22-bookjson-配置示例)

方法二:

    npm install gitbook-plugin-multipart -g
    然后编辑 book.json 添加 multipart 到 plugins 中：

    ```json
        "plugins": [
            "multipart"
        ],
    ```

### 主题插件

#### ComScore

ComScore 是一个彩色主题，默认的 gitbook 主题是黑白的，也就是标题和正文都是黑色的，而 ComScore 可以为各级标题添加不同的颜色，更容易区分各级标题

### 实用插件

disqus, 集成用户评论系统
multipart 插件可以将书籍分成几个部分，例如：
    GitBook Basic
    GitBook Advanced
    对有非常多章节的书籍非常有用，分成两部分后，各个部分的章节都从 1 开始编号。
toggle-chapters 使左侧的章节目录可以折叠
Splitter 使侧边栏的宽度可以自由调节

### 发布

#### GitBook发布

#### GitHub托管,集成

md托管到GitHub

#### GitHub Pages

直接手动将生成的_book推送到GitHub仓库即可

或者使用Grunt发布

grunt-gh-pages插件

## 模板

[https://toolchain.gitbook.com/templating/](https://toolchain.gitbook.com/templating/)

忽略特殊的模板标签, 输出为纯文本。

```html
{% raw %}
  this will {{ not be processed }}
{% endraw %}
```

## 参考链接

[https://zhilidali.github.io/gitbook/](https://zhilidali.github.io/gitbook/)

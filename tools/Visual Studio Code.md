# Visual Studio Code

<!-- TOC -->

- [Visual Studio Code](#visual-studio-code)
    - [Visual Studio Code Settings Sync](#visual-studio-code-settings-sync)
    - [文件默认换行符设置](#文件默认换行符设置)
    - [图床工具](#图床工具)
    - [扩展Visual Studio Code](#扩展visual-studio-code)
        - [Yo Code - Extension Generator](#yo-code---extension-generator)
            - [依赖](#依赖)
            - [安装](#安装)
            - [运行 Yo Code](#运行-yo-code)
        - [第一个扩展插件](#第一个扩展插件)
            - [生成插件](#生成插件)
            - [package.json](#packagejson)
            - [生成代码](#生成代码)
        - [打包发布](#打包发布)
            - [打包](#打包)

<!-- /TOC -->

## Visual Studio Code Settings Sync

使用插件同步vscode配置

其实就是借助的`GitHub Gist`, Gist可以设置为`public`和`secret`, 该插件会创建一个`secret`的gist, 所以设置里面有key之类的, 也不是很要紧

[Gist](https://gist.github.com)

[Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)

[GitHub shanalikhan/code-settings-sync](https://github.com/shanalikhan/code-settings-sync)

## 文件默认换行符设置

在vscode设置, 文件默认换行符号

```json
  // The default end of line character. Use \n for LF and \r\n for CRLF.
  // LF 为 "\n"
  // Windows 使用 CRLF 作为换行符
  "files.eol": "\n"
```

## 图床工具

可以自己写一个, 或者直接使用GitHub, 仓库内的图片是可以直接通过链接来访问的.

[shanalikhan/code-settings-sync](https://github.com/shanalikhan/code-settings-sync)

## 扩展Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com/docs/extensions/overview)

### Yo Code - Extension Generator

#### 依赖

- [npm](https://nodejs.org/en/)
- 配置环境变量, 可以直接使用npm命令

#### 安装

    npm install -g yo generator-code

官方镜像速度慢, 可以使用淘宝的[NPM镜像](http://npm.taobao.org/)

添加别名

```shell
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

# 可以添加到 .bashrc 或 .zshrc
$ echo '\n#alias for cnpm\nalias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"' >> ~/.zshrc && source ~/.zshrc
```

使用cnpm安装

    cnpm install -g yo generator-code

#### 运行 Yo Code

    yo code

### 第一个扩展插件

[Example - Hello World](https://code.visualstudio.com/docs/extensions/example-hello-world)

#### 生成插件

    yo code

选择 `TypeScript` 类型插件, 按要求输入信息.

- `File` -> `Open Folder`
- 按`F5`或者,点击`Debug`, 点击`Start`
- 会自动打开一个新的`VS Code`窗口, 并支持该扩展插件
- 按 `⇧⌘P` 运行命令 `Hello World.`
- 此时你的扩展插件会显示一条 `Hello World` 的信息

> 插件目录结构

运行之后, 插件目录结构如下

```shell
.
├── .gitignore
├── .vscode                     // VS Code integration
│   ├── launch.json
│   ├── settings.json
│   └── tasks.json
├── .vscodeignore
├── README.md
├── src                         // sources
│   └── extension.ts            // extension.js, in case of JavaScript extension
├── test                        // tests folder
│   ├── extension.test.ts       // extension.test.js, in case of JavaScript extension
│   └── index.ts                // index.js, in case of JavaScript extension
├── node_modules
│   ├── vscode                  // language services
│   └── typescript              // compiler for typescript (TypeScript only)
├── out                         // compilation output (TypeScript only)
│   ├── src
│   |   ├── extension.js
│   |   └── extension.js.map
│   └── test
│       ├── extension.test.js
│       ├── extension.test.js.map
│       ├── index.js
│       └── index.js.map
├── package.json                // extension's manifest
├── tsconfig.json               // jsconfig.json, in case of JavaScript extension
└── vsc-extension-quickstart.md // extension development quick start
```

#### package.json

- [extension manifest reference](https://code.visualstudio.com/docs/extensionAPI/extension-manifest)
- [contribution points](https://code.visualstudio.com/docs/extensionAPI/extension-points)
- 每一个VS Code插件都有一个`package.json`文件描述自身及功能
- VS Code在启动的时候会读取该文件, 并立刻启用每一个`contributes`

示例

```json
{
    "name": "myFirstExtension",
    "description": "",
    "version": "0.0.1",
    "publisher": "",
    "engines": {
        "vscode": "^1.5.0"
    },
    "categories": [
        "Other"
    ],
    "activationEvents": [
        "onCommand:extension.sayHello"
    ],
    "main": "./out/src/extension",
    "contributes": {
        "commands": [{
            "command": "extension.sayHello",
            "title": "Hello World"
        }]
    },
    "scripts": {
        "vscode:prepublish": "tsc -p ./",
        "compile": "tsc -watch -p ./",
        "postinstall": "node ./node_modules/vscode/bin/install",
        "test": "node ./node_modules/vscode/bin/test"
    },
    "devDependencies": {
       "typescript": "^2.0.3",
        "vscode": "^1.5.0",
        "mocha": "^2.3.3",
        "@types/node": "^6.0.40",
        "@types/mocha": "^2.2.32"
   }
}
```

> 注意: JavaScript扩展插件不需要`scripts`, 因为不需要编译.

这个特殊文件描述了

- 一个命令面板的入口, 标签为`"Hello World"`, 它会调用`"extension.sayHello"`
- 当`"extension.sayHello"`被调用的时候, 会请求加载活动事件
- 该事件是使用JavaScript编写的`"./out/src/extension.js"`文件

> 注意: VS Code不会在启动的时候就加载扩展代码. 扩展插件必须描述, 通过`activationEvents`性能, 在某些条件下被激活(加载).

#### 生成代码

生成的扩展插件代码在`extension.ts`(或 `extension.js`, JavaScript扩展插件)里面

```javascript
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // This line of code will only be executed once when your extension is activated
    console.log('Congratulations, your extension "my-first-extension" is now active!');

    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    var disposable = vscode.commands.registerCommand('extension.sayHello', () => {
        // The code you place here will be executed every time your command is executed

        // Display a message box to the user
        vscode.window.showInformationMessage('Hello World!');
    });

    context.subscriptions.push(disposable);
}
```

- 每个插件都需要有一个`activate()`函数, VS Code将在`package.json`里面描述的`activationEvents`发生的时候, 调用一次.
- 如果插件使用OS资源, 可以定义一个`deactivate()`函数, 当VS Code关闭的时候, 会调用该函数, 执行清扫工作.
- 这个插件导入了`vscode` API, 并注册了一个命令, 调用命令`"extension.sayHello"`, 显示一条`"Hello World"`的信息.

> 注意: `package.json`里面的`contributes`会在命令面板增加一个入口, 在`.ts/.js`里面实现该命令`"extension.sayHello"`
> 注意: 对于`TypeScript`插件, VS Code会在每一次执行的时候加载生成的`out/src/extension.js`文件.

### 打包发布

[Publishing Extensions](https://code.visualstudio.com/docs/extensions/publish-extension)

#### 打包

> 安装

    npm install -g vsce

直接在命令行使用 `vsce` 命令

    vsce package

发布

    vsce publish

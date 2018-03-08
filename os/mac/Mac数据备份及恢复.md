# Mac

## Mac备份

1. 私钥公钥
2. 相关软件配置文件
    1. iTerm2

## Mac恢复

### 命令行恢复

[oh-my-zsh](http://ohmyz.sh)

```shell
# 安装Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 安装wget
brew install wget

# Install oh-my-zsh now
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### iTerm2恢复

解压配置文件到如下目录,进入到iTerm2配置,勾选配置

![ITerm2-save history to disk-2](http://oi480zo5x.bkt.clouddn.com/ITerm2-save%20history%20to%20disk-2.png)

### 鼠标放置屏幕右上角锁屏

![MacOS-1](http://oi480zo5x.bkt.clouddn.com/MacOS-1.png)

![MacOS-2](http://oi480zo5x.bkt.clouddn.com/MacOS-2.png)

### 触摸板配置

![MacOS-3](http://oi480zo5x.bkt.clouddn.com/MacOS-3.png)

三指拖动选择

![MacOS-4](http://oi480zo5x.bkt.clouddn.com/MacOS-4.png)

### vscode 恢复

**可以直接使用settings-sync插件同步配置**

命令面板

    >shell command

选择 `Install "code" command in PATH`

> vscode配置恢复

**vscode User Settings**

```json
// 将设置放入此文件中以覆盖默认设置
{
    "window.zoomLevel": 1,
    "editor.minimap.enabled": true,
    "editor.fontSize": 15,

    // 七牛图片上传工具开关
    "qiniu.enable": true,

    // 一个有效的七牛 AccessKey 签名授权。
    "qiniu.access_key": "xxxxxxxxxxxx",

    // 一个有效的七牛 SecretKey 签名授权。
    "qiniu.secret_key": "xxxxxxxxxxxx",

    // 七牛图片上传空间。
    "qiniu.bucket": "yangjinjie",

    // 七牛图片上传路径，参数化命名。
    "qiniu.remotePath": "${fileName}",

    // 七牛图床域名。
    "qiniu.domain": "http://oi45x.bkt.clouddn.com",
    "workbench.colorTheme": "Default Light+",
    "workbench.iconTheme": "vscode-icons",
}
```

### 搜狗输入法,使用QQ登录

[皮肤: 书写优雅](http://oi480zo5x.bkt.clouddn.com/书写优雅.mssf)

### 常用软件

* Go2Shell
* iTerm2
* The Unarchiver | 避免解压后文件名乱码
* Patterns | 正则
* Kaleidoscope | 比较
* Charles | 抓包
* iStat Menus | 状态栏工具
* Shadowsocks
* Typora

* Bartender 3 | Mac Menu Bar Item Control

* Clearview | 电子书阅读器, 支持 PDF, EPUB, CHM, MOBI, FB2, CBR, CBZ 等流行的图书格式

* [截图 http://jietu.qq.com](http://jietu.qq.com) (有道词典, 划词选词会导致QQ截图之类的失效)
* Camtasia 3 | 录屏

* 远程控制
    * Remote Desktop Connection
    * TeamView

* 开发类工具
    * IntelliJ IDEA
    * PyCharm
    * Navicat Premium | 数据库

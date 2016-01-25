# Mac使用过程中问题记录

<!-- TOC -->

- [Mac使用过程中问题记录](#mac使用过程中问题记录)
    - [查看端口命令](#查看端口命令)
    - [查看路由表](#查看路由表)
    - [TextEdit打开文件中文乱码](#textedit打开文件中文乱码)
    - [Mac压缩包解压后乱码](#mac压缩包解压后乱码)
    - [重装/升级Mac系统之后发现capslock锁定大小写的键,失灵了,居然可以用来切换输入法了.](#重装升级mac系统之后发现capslock锁定大小写的键失灵了居然可以用来切换输入法了)
    - [macOS Sierra 10.12 打开无法确认开发者身份的软件包方法](#macos-sierra-1012-打开无法确认开发者身份的软件包方法)
    - [第三方软件安装之后,打开提示已损坏,打不开,可使用如下方法解决](#第三方软件安装之后打开提示已损坏打不开可使用如下方法解决)

<!-- /TOC -->

## 查看端口命令

    netstat -AaLlnW
    lsof -i -P | grep "LISTEN"

## 查看路由表

    netstat -rn

    默认网关
    route -n get default OR route -n get www.yahoo.com

## TextEdit打开文件中文乱码

Mac查看txt中文乱码

解决办法:

![MacOS-TextEdit-01](http://oi480zo5x.bkt.clouddn.com/MacOS-TextEdit-01.png)

## Mac压缩包解压后乱码

使用解压软件 The Unarchiver 来解压 Zip 格式的文件。

[App Store The Unarchiver](
https://itunes.apple.com/app/the-unarchiver/id425424353?mt=12&amp;ls=1)

在压缩包上`Get info` -> `Open with` -> 选择`The Unarchiver` -> 并改变所有

## 重装/升级Mac系统之后发现capslock锁定大小写的键,失灵了,居然可以用来切换输入法了.

原因:

使用以下几种方法处理：

方式一：长按 caps lock 键，来切换大小写

方式二：caps lock + shift , 来切换大小写

方式三：在键盘设置里面把大小写切换语言勾点掉就好了，然后按大写就是大写，中文下按大就直接是英语或者拼音。

## macOS Sierra 10.12 打开无法确认开发者身份的软件包方法

## 第三方软件安装之后,打开提示已损坏,打不开,可使用如下方法解决

1.10.12打不开无法确认开发者身份的软件包方法：

[Gatekeeper] 在系统偏好设置->安全&隐私中默认已经去除了允许安装任何来源App的选项，如需要重新设置成允许任何来源，即关闭Gatekeeper，请在终端中使用spctl命令：

    sudo spctl --master-disable

**注意，如在偏好设置中重新选择仅允许运行来自MAS或认证开发者App，即重新开启Gatekeeper之后，允许任何来源App的选项会再次消失，可通过上述命令再次关闭。**

不显示"任何来源"选项（macOS 10.12默认为不显示）在控制台中执行：

    sudo spctl --master-enable


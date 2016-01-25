# iterm2

<!-- TOC -->

- [iterm2](#iterm2)
    - [配色](#配色)
    - [快捷键](#快捷键)
        - [标签](#标签)
        - [分屏](#分屏)
        - [其他快捷键](#其他快捷键)
        - [其他快捷键2](#其他快捷键2)
        - [高亮当前鼠标的位置](#高亮当前鼠标的位置)
        - [Linux 下好用的组合](#linux-下好用的组合)
        - [选中即复制](#选中即复制)
        - [路径重复](#路径重复)
        - [系统热键*****](#系统热键)
        - [弹出历史记录窗口](#弹出历史记录窗口)
        - [自动完成(弹出自动补齐窗口)](#自动完成弹出自动补齐窗口)
        - [全屏切换](#全屏切换)
        - [Expose所有Tab(全屏展示所有的 tab)](#expose所有tab全屏展示所有的-tab)
        - [保存当前快照](#保存当前快照)
        - [恢复快照：](#恢复快照)
- [一些实用功能](#一些实用功能)
    - [shell integration](#shell-integration)
    - [Utilities Package](#utilities-package)
    - [Broadcast Input(对多会话同时操作)](#broadcast-input对多会话同时操作)

<!-- /TOC -->

## 配色

选择喜欢的配色方案

    在Preferences->Profiles->Colors的load presets可以选择某个配色方案。也可以自己下载。在网站http://iterm2colorschemes.com/，几乎可以找到所有可用的配色方案。

## 快捷键

### 标签

    新建标签：command + t
    关闭标签：command + w
    切换标签：command + 数字 command + 左右方向键   cmd + { ,  cmd + }
    切换全屏：command + enter
    查找：command + f

### 分屏

    垂直分屏(横向分布)：command + d
    水平分屏(竖向分布)：command + shift + d
    切换屏幕：command + option + 方向键 command + [ 或 command + ]
    查看历史命令：command + ;
    查看剪贴板历史：command + shift + h

### 其他快捷键

    清除当前行,无论光标在什么位置：ctrl + u
    到行首：ctrl + a
    到行尾：ctrl + e
    前进后退：ctrl + f/b (相当于左右方向键)
    上一条命令：ctrl + p
    搜索命令历史：ctrl + r
    删除当前光标的字符：ctrl + d
    删除光标之前的字符：ctrl + h
    删除光标之前的单词：ctrl + w
    删除到文本末尾：ctrl + k
    交换光标处文本：ctrl + t
    清屏1：command + r = clear 不过只是换到新一屏，不会想 clear 一样创建一个空屏
    清屏2：ctrl + l
    智能能查找，支持正则查找：cmd + f

    ⌘← / ⌘→ 到一行命令最左边/最右边 ，这个功能同 C+a / C+e
    ⌥← / ⌥→ 按单词前移/后移，相当与 C+f / C+b，其实这个功能在Iterm中已经预定义好了，⌥f / ⌥b，看个人习惯了

### 其他快捷键2

    选择即复制 + 鼠标中键粘贴，这个很实用
    ⌘ + f 所查找的内容会被自动复制
    输入开头命令后 按 ⌘ + ; 会自动列出输入过的命令
    ⌘ + shift + h 会列出剪切板历史
    可以在 Preferences > keys 设置全局快捷键调出 iterm，这个也可以用过 Alfred 实现

### 高亮当前鼠标的位置

一个标签页中开的窗口太多，有时候会找不到当前的鼠标，`cmd + /` 找到它。

### Linux 下好用的组合

    Ctrl+a / Ctrl+e 这个几乎在哪都可以使用
    Ctrl+p / !! 上一条命令
    Ctrl+k 从光标处删至命令行尾 (本来 Ctrl+u 是删至命令行首，但iterm中是删掉整行)
    Ctrl+w A+d 从光标处删至字首/尾
    Ctrl+h Ctrl+d 删掉光标前后的自负
    Ctrl+y 粘贴至光标后
    Ctrl+r 搜索命令历史，这个较常用

### 选中即复制

iterm2有2种好用的选中即复制模式。

    一种是用鼠标，在iterm2中，选中某个路径或者某个词汇，那么，iterm2就自动复制了。

    另一种是无鼠标模式，command+f,弹出iterm2的查找模式，输入要查找并复制的内容的前几个字母，确认找到的是自己的内容之后，输入tab，查找窗口将自动变化内容，并将其复制。如果输入的是shift+tab，则自动将查找内容的左边选中并复制。

### 路径重复

在新Tab中自动使用前一Tab路径，如此设置

![iTerm2-Working Directory-2017221](http://oi480zo5x.bkt.clouddn.com/iTerm2-Working%20Directory-2017221.jpg)

### 系统热键*****

如下图，设置好系统热键之后，将在正常的浏览器或者编辑器等窗口的上面，以半透明窗口形式直接调出iterm2 shell。

按下同样的系统热键之后，将自动隐藏。这样非常有利于随时随地处理。

![iTerm2-Hotkey-2017221](http://oi480zo5x.bkt.clouddn.com/iTerm2-Hotkey-2017221.jpg)

### 弹出历史记录窗口

iTerm2 也可以使用历史记录，按 `cmd + Shift + h` 弹出历史记录窗口。

### 自动完成(弹出自动补齐窗口)

    输入打头几个字母，然后输入command+; iterm2将自动列出之前输入过的类似命令。

这里写图片描述
剪切历史

    输入command+shift+h，iterm2将自动列出剪切板的历史记录。如果需要将剪切板的历史记录保存到磁盘，在Preferences > General > Save copy/paste history to disk.中设置。

![ITerm2-save history to disk-2017221](http://oi480zo5x.bkt.clouddn.com/ITerm2-save%20history%20to%20disk-2017221.jpg)

### 全屏切换

    command+enter 进入 或 返回全屏模式

### Expose所有Tab(全屏展示所有的 tab)

    command+option+e,并且可以搜索

### 保存当前快照

    Window > Save Window Arrangement.

### 恢复快照：

    Window > Restore Window Arrangement
        可以在Preferences > General > Open saved window arrangement.设置自动恢复快照

# 一些实用功能

## shell integration

[documentation-shell-integration](https://iterm2.com/documentation-shell-integration.html)

## Utilities Package

You will also have these commands:

    imgcat filename

Displays the image inline.

    it2dl filename

Downloads the specified file, saving it in your Downloads folder.

## Broadcast Input(对多会话同时操作)

![ITerm2-Broadcast Input](http://oi480zo5x.bkt.clouddn.com/ITerm2-Broadcast%20Input.png)
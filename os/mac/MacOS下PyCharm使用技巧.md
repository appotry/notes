# PyCharm

## 命令行使用pycharm打开PyCharm

添加别名到 `.zshrc` 或者类似 `.bashrc`

```shell
➜  ~ tail -1 .zshrc
alias pycharm="open -a pycharm"
```

重新打开终端, 或者使用source生效

在当前目录打开PyCharm

```shell
➜  records git:(master) ✗ pycharm .
```

## PyCharm快捷键

```shell
cmd+d 在下一行复制本行的内容
opt + cmd + l 代码块对齐
Tab / Shift + Tab 缩进、不缩进当前行
cmd b 跳转到声明处（cmd加鼠标）
opt + 空格 显示符号代码 （esc退出窗口 回车进入代码）
cmd []光标之前/后的位置
opt + F7 find usage
cmd backspace 删除当前行
cmd +c 复制光标当前行,剪切同理
cmd + f 当前文件搜索（回车下一个 shift回车上一个）
cmd + r 当前文件替换
shift + cmd + f 全局搜索
shift + cmd + R 全局替换
cmd+o 搜索class
shift + cmd + o 搜索文件
opt + cmd + o 搜索符号（函数等)
cmd + l 指定行数跳转
shift enter 在行中的时候直接到下一行
cmd + 展开当前
cmd - 折叠当前
shift cmd + 展开所有
shift cmd - 折叠所有
cmd / 注释/取消注释一行(选中批量注释)
opt + cmd + / 批量注释(pycharm不生效)
ctr + tab 史上最NB的导航窗口（工程文件列表、文件结构列表、命令行模式、代码检查、VCS等，下面两个是可以被替换的）
alt + F12 打开命令行栏
cmd + F12 显示文件结构
cmd j 代码智能补全
alt + F1 定位编辑文件所在位置:
cmd + F6 更改变量
opt + cmd + t 指定代码被注释语句或者逻辑结构、函数包围
```
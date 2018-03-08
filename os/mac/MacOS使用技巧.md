# MacOS使用技巧

## Mac_Fn键功能设置

![MacOS-5](http://oi480zo5x.bkt.clouddn.com/MacOS-5.png)

## Mac 快捷键

Control-Command-F 全屏

Option-Command-D  显示或隐藏 Dock

Command-P 显示“打印”对话框

Option-Command-esc 强制退出

![MacOS-6](http://oi480zo5x.bkt.clouddn.com/MacOS-6.jpeg)

## Safari

### 快捷键

#### 标签(tab)操作

```xxx
shitt+comamnd+\：所有标签页，可配合左右键和单指左右滑动。对应手势操作：双指捏合、放开。
command+T：新建标签
command+L/option(alt)+command+F/fn＋control+F5：定位地址栏/聚焦搜索栏
option(alt)+command+1：当前标签页显示个人收藏栏，并定位地址栏
command+enter：聚焦地址栏输入时，新标签页后台打开地址或搜索
shift+command+enter：聚焦地址栏输入时，新标签页前台打开地址或搜索
command+点按：新标签页后台打开链接
shift+command+点按：新标签页前台打开链接
control+tab/shift+command+]/shift+command+→：显示下一个标签页，其中箭头对空tab无效。
control+shift+tab/shift+command+[/shift+command+←：显示上一个标签页，其中箭头对空tab无效。
shift+command+H：当前标签页打开默认主页
command+[/]或单指左右滑动：当前标签页内前进/后退
command+W：关闭当前标签页
command+Z：恢复最近关闭的标签页
command+R：刷新重载
command+.：停止刷新重载
shift+command+R：进入阅读器模式
```

#### 书签(bookmarks)操作

```xxx
control+command+1: 显示书签边栏
command+D：添加到收藏夹（书签栏）
option(alt)+command+B：管理/编辑书签页
shift+command+N：新建书签文件夹
```

#### 阅读列表(Read it later list)

```xxx
control+command+2: 显示阅读列表边栏
shift+command+D：将当前页添加到阅读列表
shift+点按：将链接添加到阅读列表
option(alt)+command+↑：阅读列表上一个项目
option(alt)+command+↓：阅读列表下一个项目
```

#### 显示/隐藏

```xxx
shift+command+B：收藏栏
shift+command+T：标签页栏
shift+command+L：侧边栏（书签／阅读）
option(alt)+command+L：下载
option(alt)+command+2：显示历史记录
```

#### 查找

```xxx
command+F：查找
command+G/enter：查找下一个
shift+command+G/shift+enter：查找上一个
```

#### 缩放

```xxx
command++：放大
command+-：缩小
command+0：恢复默认
双指点触：智能缩放
```

#### 查看扩展

```xxx
command+,：偏好设置->扩展
```

## 禁用Dashboard

关闭Dashboard

System Preferences -> Mission Control -> 设置Dashboard即可

### 终端执行

defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock

### 重新开启

defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock

## 空间释放

### 完全删除GarageBand

[参考](https://www.tekrevue.com/tip/delete-garageband/)

```shell
sudo rm -rf /Library/Application\ Support/GarageBand/
sudo rm -rf /Library/Application\ Support/Logic
sudo rm -rf /Library/Audio/Apple\ Loops
sudo rm -rf /Applications/GarageBand.app
```

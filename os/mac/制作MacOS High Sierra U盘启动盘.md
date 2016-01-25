# 制作U盘启动盘

## 使用磁盘工具

![Upan-1](http://oi480zo5x.bkt.clouddn.com/Upan-1.jpg)

## 打开终端, 执行命令

```shell
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Sierra --applicationpath /Applications/Install\ macOS\ High\ Sierra.app --nointeraction
```

正常情况, 显示

```shell
# 提示密码
Erasing Disk: 0%... 10%... 20%... 30%...100%...
Copying installer files to disk...
Copy complete.
Making disk bootable...
Copying boot files...
Copy complete.
Done.
```

如果提示 `/Applications/Install macOS High Sierra.app does not appear to be a valid OS installer application.`, 尝试命令后面添加 `&& say Done`, 执行

```shell
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Sierra --applicationpath /Applications/Install\ macOS\ High\ Sierra.app --nointeraction && say Done
```

还有, 如果还是有问题, 可以尝试把商店换到美国区重新下载。

国区 4.68G 的不行，美区 5.18G 的可以。

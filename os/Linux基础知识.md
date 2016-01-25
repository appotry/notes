# Linux基础知识

## Linux里面软件的安装方法：

1、 rpm -ivh 包名.rpm

* 有依赖问题，安装A，A需要先安装B。
* 缺点：不能定制。

2、 yum安装自动解决rpm安装的依赖问题，安装更简单化。

* 优点：简单、易用、高效
* 缺点：不能定制。

3、 编译（C语言源码-编译二进制等）

* ./configure(配置)，make(编译)，make install(安装)
* 优点：可以定制
* 缺点：复杂、效率低。

4、 定制化制作rpm包，搭建yum仓库，把我定制的rpm包放到yum仓库，进行yum安装

* 优点：结合了2和3的优点
* 缺点：复杂

## grub菜单添加密码

命令行执行 `/sbin/grub-md5-crypt`  产生密码

然后修改

vim /etc/grub.conf

在 splashimage和title之间，
添加password --md5 ..生成的加密后的md5值

```shell
    default=0
    timeout=5
    splashimage=(hd0,0)/grub/splash.xpm.gz
    hiddenmenu
    title CentOS (2.6.32-642.3.1.el6.x86_64)
    root (hd0,0)
    kernel /vmlinuz-2.6.32-642.3.1.el6.x86_64 ro root=UUID=d5a03e22-61ab-43b0-9cd7-ca9a5
    869205d rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel
    =auto  KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM rhgb quiet
    initrd /initramfs-2.6.32-642.3.1.el6.x86_64.img
    title CentOS 6 (2.6.32-573.el6.x86_64)
    root (hd0,0)
    kernel /vmlinuz-2.6.32-573.el6.x86_64 ro root=UUID=d5a03e22-61ab-43b0-9cd7-ca9a58692
    05d rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=aut
    o  KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM rhgb quiet
    initrd /initramfs-2.6.32-573.el6.x86_64.img
```
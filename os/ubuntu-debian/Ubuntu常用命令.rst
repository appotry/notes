Ubuntu命令大全
==============

    作者: 李春梅 邮箱：lichunmei@rivamed.cn QQ：2364640877、2994654462

Ubuntu常用命令大全
------------------

.. code:: shell

    查看xxx软件安装内容：dpkg -L xxx
    查找软件：apt-cache search 正则表达式
    查找文件属于哪个包：dpkg -S filename apt-file search filename
    查询软件 xxx 依赖哪些包：apt-cache depends xxx
    查询软件 xxx 被哪些包依赖：apt-cache rdepends xxx
    增加一个光盘源：sudo apt-cdrom add
    系统升级：sudo apt-get update、sudo apt-get upgrade、sudo apt-get dist-upgrade
    清除所有删除包的残余配置文件：dpkg -l |grep ^rc|awk ‘{print $2}’ |tr [”\n”] [” “]|sudo xargs dpkg -P
    编译时缺少 h 文件的自动处理：sudo auto-apt run ./configure
    查看安装软件时下载包的临时存放目录：ls /var/cache/apt/archives
    备份当前系统安装的所有包的列表：dpkg –get-selections | grep -v deinstall > ~/somefile
    从上面备份的安装包的列表文件恢复所有包：dpkg –set-selections < ~/somefile sudo dselect
    清理旧版本的软件缓存：sudo apt-get autoclean
    清理所有软件缓存：sudo apt-get clean
    删除系统不再使用的孤立软件：sudo apt-get autoremove
    查看包在服务器上面的地址：apt-get -qq –print-uris install ssh | cut -d\’ -f2

系统
----

.. code:: shell

    查看内核：uname -a
    查看 Ubuntu 版本：cat /etc/issue
    查看内核加载的模块：lsmod
    查看 PCI 设备：lspci
    查看 USB 设备：lsusb
    查看网卡状态：sudo ethtool eth0
    查看 CPU 信息cat /proc/cpuinfo
    显示当前硬件信息：lshw

硬盘
----

-  查看硬盘的分区：sudo fdisk -l
-  查看 IDE 硬盘信息：sudo hdparm -i /dev/hda
-  查看 STAT 硬盘信息：sudo hdparm -I /dev/sda或sudo apt-get install
   blktool、sudo blktool /dev/sda id
-  查看硬盘剩余空间：df -h、df -H
-  查看目录占用空间：du -hs 目录名
-  优盘没法卸载：sync fuser -km /media/usbdisk

内存
----

查看当前的内存使用情况：free -m

进程
----

.. code:: shell

    查看当前有哪些进程：ps -A
    中止一个进程：kill 进程号(就是 ps -A 中的第一列的数字) 或者 killall 进程名
    强制中止一个进程(在上面进程中止不成功的时候使用)：kill -9 进程号 或者 killall -9 进程名
    图形方式中止一个程序：xkill 出现骷髅标志的鼠标，点击需要中止的程序即可
    查看当前进程的实时状况：top
    查看进程打开的文件：lsof -p
    ADSL 配置 ADSL：sudo pppoeconf
    ADSL 手工拨号：sudo pon dsl-provider
    激活 ADSL：sudo /etc/ppp/pppoe_on_boot
    断开 ADSL：sudo poff
    查看拨号日志：sudo plog
    如何设置动态域名：首先去 http://www.3322.org 申请一个动态域名
    然后修改 /etc/ppp/ip-up 增加拨号时更新域名指令 sudo vim /etc/ppp/ip-up
    最后增加如下行 w3m -no-cookie -dump

网络
----

.. code:: shell

    根据 IP 查网卡地址：arping IP 地址
    查看当前 IP 地址：ifconfig eth0 |awk ‘/inet/ {split($2,x,”:”);print x[2]}’
    查看当前外网的 IP 地址：w3m -no-cookie -dumpwww.edu.cn|grep-o‘[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}’ 或 w3m -no-cookie -dumpwww.xju.edu.cn|grep-o’[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}’ 或者 w3m -no-cookie -dump ip.loveroot.com|grep -o’[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}’
    查看当前监听 80 端口的程序：lsof -i :80
    查看当前网卡的物理地址：arp -a | awk ‘{print $4}’ ifconfig eth0 | head -1 | awk ‘{print $5}’
    立即让网络支持 nat：sudo echo 1 > /proc/sys/net/ipv4/ip_forward 或者 sudo iptables -t nat -I POSTROUTING -j MASQUERADE
    查看路由信息：netstat -rn sudo route -n
    手工增加删除一条路由：sudo route add -net 192.168.0.0 netmask 255.255.255.0 gw 172.16.0.1 或者 sudo route del -net 192.168.0.0 netmask 255.255.255.0 gw 172.16.0.1
    修改网卡 MAC 地址的方法：sudo ifconfig eth0 down 关闭网卡       sudo ifconfig eth0 hw ether 00:AA:BB:CC:DD:EE 然后改地址 sudo ifconfig eth0 up 然后启动网卡
    统计当前 IP 连接的个数：netstat -na|grep ESTABLISHED|awk ‘{print $5}’|awk -F: ‘{print $1}’|sort|uniq -c|sort -r -n
    netstat -na|grep SYN|awk ‘{print $5}’|awk -F: ‘{print $1}’|sort|uniq -c|sort -r -n
    统计当前 20000 个 IP 包中大于 100 个 IP 包的 IP 地址：tcpdump -tnn -c 20000 -i eth0 | awk -F “.” ‘{print $1″.”$2″.”$3″.”$4}’| sort | uniq -c | sort -nr | awk ‘ $1 > 100 ‘
    屏蔽 IPV6：e cho “blacklist ipv6″ | sudo tee /etc/modprobe.d/blacklist-ipv6

服务
----

-  添加一个服务：sudo update-rc.d 服务名 defaults 99
-  删除一个服务：sudo update-rc.d 服务名 remove
-  临时重启一个服务：/etc/init.d/服务名 restart
-  临时关闭一个服务：/etc/init.d/服务名 stop
-  临时启动一个服务：/etc/init.d/服务名 start

设置
----

.. code:: shell

    配置默认 Java 使用哪个：sudo update-alternatives –config java
    修改用户资料：sudo chfn userid
    给 apt 设置代理：export http_proxy=http://xx.xx.xx.xx:xxx
    修改系统登录信息：sudo vim /etc/motd

中文
----

.. code:: shell

    转换文件名由 GBK 为 UTF8：sudo apt-get install convmv convmv -r -f cp936 -t utf8 –notest –nosmart *
    批量转换 src 目录下的所有文件内容由 GBK 到 UTF8：find src -type d -exec mkdir -p utf8/{} \; find src -type f -exec iconv -f GBK -t UTF-8 {} -o utf8/{} \; mv utf8/* src rm -fr utf8
    转换文件内容由 GBK 到 UTF8：iconv -f gbk -t utf8 $i > newfile
    转换 mp3 标签编码：sudo apt-get install python-mutagen find . -iname “*.mp3” -execdir mid3iconv -e GBK {} \;
    控制台下显示中文：sudo apt-get install zhcon 使用时，输入 zhcon 即可

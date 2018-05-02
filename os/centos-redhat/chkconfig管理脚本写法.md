# chkconfig管理脚本写法

> vim /etc/init.d/testd

```shell
#!/bin/sh
#
#  chkconfig: 2345 68 73
#
echo ┏┛┻━━━━━━┛┓;sleep 0.5;
echo ┃　┳┛ ┗┳   ┃;sleep 0.5;
echo ┃　┳┛ ┗┳   ┃;sleep 0.5;
echo ┃　  ┻　 　┃;sleep 0.5;
echo ┃　　　　　┃;sleep 0.5;
echo ┗━┓　　　┏━┛;sleep 0.5;
echo 　┃  神　┃　　;sleep 0.5;
echo 　┃　兽  ┃　　;sleep 0.5;
echo 　┃　来  ┃　　;sleep 0.5;
echo 　┃　袭　┃;sleep 0.5;
echo 　┃　吼　┗━━━┓;sleep 0.5;
echo 　┃  ！      ┣┓;sleep 0.5;
echo 　┃          ┃;sleep 0.5;
echo 　┗┓┓┏━┳┓┏┛;sleep 0.5;
echo     ┃┫┫　┃┫┫;sleep 0.5;
echo 　　┗┻┛　┗┻┛;sleep 0.5;
for n in `seq 100` ;do echo loading......$n% ;sleep 1;done

# 添加权限
chmod +x /etc/init.d/testd
chkconfig --add testd
chkconfig testd on
chkconfig|grep test
```
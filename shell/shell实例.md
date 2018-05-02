# shell实例

## 在/home目录中创建一百个目录，目录名称依次为a1……a100

```shell
for i in `seq 100`; do mkdir /home/a$i; done
```

## 编写一个脚本，自动将用户主目录下所有小于5KB的文件打包成XX.tar.gz.（提示：用ls，grep,find等命令，文件一般指普通文件）

```shell
find ~ -size -5 -type f -maxdepth 1|xargs tar zcvpf backup.tar.gz
```

## 写一个程序，可以将/et/passwd的第一列取出，而且每一列都以一行字符串“the 1 account is “root””来显示

```shell
awk -F':' '{print "the 1 account is "$1}' /etc/passwd
```

## 编写一个程序，他的作用是先查看一下/root/test/logical这个名称是否存在，若不存在，则创建一个文件。使用touch来创建，创建完成后离开；如果存在的话，判断该名称是否为文件，若为文件则将之删除后新建一个目录。文件名为loglical，之后离开;如果存在的话，而且该名称为目录，则删除此目录。

```shell
if [ ! -e "/root/test/logical" ]; then touch "hh";  elif [ -f "/root/test/logical" ];then rm /root/test/logical && mkdir logical&&exit;elif  [ -d "/root/test/logical" ];then rm /root/test/logical; fi
```

## 编写一个shell脚本，从键盘读入10个数，显示最大值和最小值。

```shell
#! /bin/bash
printf "Enter 10 number: "
read
biggest=$(echo "$REPLY" | tr ' ' '\n' | sort -rn | head -n1)
smallest=$(echo "$REPLY" |  tr ' ' '\n' | sort -rn | tail -n1)
echo "Biggest number:  $biggest"
echo "Smallest number:  $smallest"
--------------------------------------------------
```

运行结果

```shell
=> sh hh.sh
Enter 10 number: 1 2 3 4 5 6 7 8 9 0
Biggest number:  9
Smallest number:  0

```

## 编写一个脚本，打印任何数的乘法表。如输入3则打印

```shell
  1*1=1
  2*1=2 2*2=4
  3*1=3 3*2=6 3*3=9
```

```shell
awk -vstr='3' 'BEGIN{for(i=1;i<=str;i++){for(p=1;p<=i;p++)printf p"*"i"="p*i"\t";printf "\n"}}'
```

## 编写一个脚本，输入自己的生日时间（YYYYMMDD），计算还有多少天多少个小时是自己的生日。

```shell
=> sh hh.sh
Input your birthday(YYYYmmdd):19930302
There is : 325 days 8 hours.

=> cat hh.sh
read -p "Input your birthday(YYYYmmdd):" date1
m=`date --date="$date1" +%m`
d=`date --date="$date1" +%d`
date_now=`date +%s`
y=`date +%Y`
birth=`date --date="$y$m$d" +%s`
internal=$(($birth-$date_now))
if [ "$internal" -lt "0" ]; then
    birth=`date --date="$(($y+1))$m$d" +%s`
    internal=$(($birth-$date_now))
 fi
awk -vinternal=$internal 'BEGIN{d=int(internal/60/60/24);h=int((internal-24*60*60*d)/3600);print "There is : "d" days "h" hours."}'

```

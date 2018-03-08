# bash技巧

bash的一些技巧

## 获取参数=后面的内容

```shell
[root@web01 ~]#　echo "--basedir=/applica" | sed -e 's/^[^=]*=//'
/applica
```

## 创建只含小写字母的随机数

    openssl rand -base64 48|sed 's#[^a-z]##g'

## 调试

    set -x  调试当前窗口命令
    set +x  取消调试
    set -e  脚本中有一条命令返回值不为零就退出脚本，可使用test，当前面脚语句执行失败的时候，执行后面的语句

## 删除无效软链接

方法1.

    for f in $(find $1 -type l); do [ -e $f ] && rm -f $f; done

方法2.

    symlinks -d

```shell
symlinks:    scan/change symbolic links - v1.2 - by Mark Lord

Usage:       symlinks [-crsv] dirlist
Flags:         -c == change absolute/messy links to relative
                   -d == delete dangling links
                   -r == recurse into subdirs
                   -s == shorten lengthy links (only displayed if -c not specified)
                   -v == verbose (show all symlinks)
```

## 统计每个文件夹占用的inode总数

```shell
find */ -exec stat -c "%n %i" {} \; | awk -F "[/ ]" '{if(! a[$1-$NF]++) l[$1]++}END{for (i in l) print i,l[i]}'
```

## 拼接时间

```shell
for n in 20 21
   do
          for  m in {00..59}
          do
             echo "$n:$m"
          done
   done
```

# 第二章

## 创建随机密码方法

1. echo $RANDOM|md5sum
2. openssl rand -base64 48
3. expect mkpasswd
    - mkpasswd -l 10
4. date +%N|sha512sum
5. head /dev/urandom|md5sum
6. uuidgen|md5sum
    - 加密可以使用 md5sum、sha512sum等等，加密之前可以添加一个干扰码，例如：echo yjj$RANDOM|md5sum

## 变量子串使用技巧

### 生成随机密码

```shell
[root@db ~]# cat pass.sh
#!/bin/bash

# Password will consist of alphanumeric characters.
MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?@#$%^&*()"

# length of password.
LENGTH="20"

while [ "${n:=1}" -le "$LENGTH" ]
  do
    PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
      let n+=1
  done
echo "$PASS"      # ==> Or, redirect to a file, as desired.
exit 0
```

[Back to TOC](#table-of-contents)

### 判断用户输入是否为数字

```shell
    read -p "Please enter the amount of recharge: " re

    if [ -n "${re//[0-9]/}" ];then
        echo "input error"
        continue
    fi

删除数字进行判断，判断是否为空

---

方法1：将数字以外的字符替换成空，如果跟本身相同，说明用户输入为数字
[root@yjj ~]# [ "`echo 1231|sed -r 's#[^0-9]##g'`" = "1231" ]&&echo 0||echo 1
0
[root@yjj ~]# [ "`echo 123a|sed -r 's#[^0-9]##g'`" = "123a" ]&&echo 0||echo 1
1
方法2：使用expr，如果命令返回结果非零，则表示用户输入的不是数字
[root@yjj ~]# expr 1 + a &>/dev/null
[root@yjj ~]# echo $?
2
```

## 计算字符串长度

```shell
    string="I love you!"
方法一：
    echo ${#string}

方法二：
    echo ${string}|wc -L

方法三：
    expr length "${string}"

方法四：
    awk '{print length($0)}' <<<$string

    awk '{print length}' <<<$string   ## $0可以省略
```

## 命令拼接

```shell
[root@web 11]# chkconfig |awk '$1!~/crond|sshd|sysstat|network|rsyslog/{print "chkconfig",$1,"off"}'|bash
```

## 计算1+2+3+4+5+6+7+8+9+10

```shell
[root@web scripts]# seq 10|awk '{a+=$1;b=b$1"+"}END{sub("+$","",b);print b"="a}'
1+2+3+4+5+6+7+8+9+10=55
```

## 打印下面语句中字符数小于6的单词

```shell
[root@db ~]# echo Whatever is worth doing is worth doing well.
Whatever is worth doing is worth doing well.

[root@db ~]# echo Whatever is worth doing is worth doing well.|awk 'END{for(i=1;i<=NF;i++)if(length($i)<6) print $i }'
is
worth
doing
is
worth
doing
well.

[root@db ~]# awk 'END{for(i=1;i<=NF;i++)if(length($i)<6) print $i }' <<< "Whatever is worth doing is worth doing well."

[root@db ~]# cat test.sh 
for n in Whatever is worth doing is worth doing well.
 do
  if [ ${#n} -lt 6 ];then
   echo $n
  fi
 done

[root@db ~]# cat test1.sh
for n in Whatever is worth doing is worth doing well.
 do
  if [ "$n" = "${n:0:6}" ];then
   echo $n
  fi
 done
```

# 使用eval实现动态变量

用变量值作新的变量名

```shell
➜  ~ refer_504_09="123"
➜  ~ time=`date +%H`
➜  ~ echo $time
09
➜  ~ echo $refer_504_09
123
➜  ~ a=`eval echo '$refer_504_'"$time"`
➜  ~ echo $a
123
```
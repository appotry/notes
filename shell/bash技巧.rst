bash技巧
========

bash的一些技巧

变量子串
--------

替换运算符
~~~~~~~~~~

::

    $(varname:-word) 如果varname存在且非null，则返回其值；否则，返回word。
    用途：如果变量未定义，则返回默认值。
    范例：如果count未定义，则$(count:-0)的值为0

获取参数=后面的内容
-------------------

.. code:: shell

    [root@web01 ~]#　echo "--basedir=/applica" | sed -e 's/^[^=]*=//'
    /applica

创建只含小写字母的随机数
------------------------

::

    openssl rand -base64 48|sed 's#[^a-z]##g'

调试
----

::

    set -x  调试当前窗口命令
    set +x  取消调试
    set -e  脚本中有一条命令返回值不为零就退出脚本，可使用test，当前面脚语句执行失败的时候，执行后面的语句

删除无效软链接
--------------

方法1.

::

    for f in $(find $1 -type l); do [ -e $f ] && rm -f $f; done

方法2.

::

    symlinks -d

.. code:: shell

    symlinks:    scan/change symbolic links - v1.2 - by Mark Lord

    Usage:       symlinks [-crsv] dirlist
    Flags:         -c == change absolute/messy links to relative
                       -d == delete dangling links
                       -r == recurse into subdirs
                       -s == shorten lengthy links (only displayed if -c not specified)
                       -v == verbose (show all symlinks)

统计每个文件夹占用的inode总数
-----------------------------

.. code:: shell

    find */ -exec stat -c "%n %i" {} \; | awk -F "[/ ]" '{if(! a[$1-$NF]++) l[$1]++}END{for (i in l) print i,l[i]}'

拼接时间
--------

.. code:: shell

    for n in 20 21
       do
              for  m in {00..59}
              do
                 echo "$n:$m"
              done
       done

xargs 处理文件名带空格的方法
----------------------------

.. code:: shell

    # 使用 -i 参数 '{}'
    xargs -i sed -i '/^<extoc>/d;2a<extoc></extoc>\n' '{}'

    # 示例
    find . -type f -name "*.md" ! -path "./README.md" -a ! -path "./SUMMARY.md"|xargs -i sed -i '/^<extoc>/d;2a<extoc></extoc>\n' '{}'

指定行插入文本内容
------------------

.. code:: shell

    # 知道行号用以下方法插入

    sed -i '88 r b.file' a.file #在a.file的第88行插入文件b.txt
    awk '1;NR==88{system("cat b.file")}' a.file >c.file

    ## 如果不知道行号，用正则匹配

    sed -i '/regex/ r b.txt' a.txt
    awk '/target/{system("cat b.txt")}' a.txt > c.txt

大小写转换
----------

.. code:: shell

    awk '{print toupper($0)}' <<< 'this is a dog!'

    # toupper()
    # tolower()

    # 全文大小写转换
    tr a-z A-Z
    tr A-Z a-z
    # 大小写互换
    echo "aBcDE" | tr '[a-zA-Z]' '[A-Za-z]'

示例

.. code:: shell

    比如说：a.txt b.txt c.txt
    更名变成 A.txt B.txt C.txt

    ls *.txt|sed -nr 's/(.)(\..*)/mv & \u\1\2/e'
    [解析]
        \u 是转换后面的内容第一个字母为大写，\U是全部为大写直到遇到 \E 为止。这就是区别：
    echo 'abc'|sed 's/^../\u&/'
    Abc
    echo 'abc'|sed 's/^../\U&\E/'
    ABc

把每个单词的第一个字母替换成大写
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``this is a dog!``

.. code:: shell

    ➜  ~ sed 's/\b[a-z]/\u&/g' <<< 'this is a dog!'
    This Is A Dog!

    # \b大家应该知道是锚定的意思，说白了就是边界符，那么这就只会匹配第一个开头的字母，然后\U的意思在元字符里的解释是“大写（不是标题首字符）\E 以前的字符”，而\u只是将下一个字符变为大写，注意它们的区别噢。

把URL中的大写字符替换成小写
~~~~~~~~~~~~~~~~~~~~~~~~~~~

``http://www.a.com/aaafkslafjlxcv/fsfa/8/Xxxx.XxXX``

.. code:: shell

    sed 's/[A-Z]/\l&/g' <<< 'http://www.a.com/aaafkslafjlxcv/fsfa/8/Xxxx.XxXX'

    # 同理\L的意思是使之变为小写。

$RANDOM 的范围是 [0, 32767]
---------------------------

第二章
------

判断技巧
~~~~~~~~

.. code:: shell

    [ -d /abc ] || mkdir -p /abc

创建随机密码方法
~~~~~~~~~~~~~~~~

1. ``echo $RANDOM|md5sum``
2. ``openssl rand -base64 48``
3. ``expect mkpasswd``

   -  ``mkpasswd -l 10``

4. ``date +%N|sha512sum``
5. ``head /dev/urandom|md5sum``
6. ``uuidgen|md5sum``

   -  加密可以使用
      ``md5sum``\ 、\ ``sha512sum``\ 等等，加密之前可以添加一个干扰码，例如：\ ``echo yjj$RANDOM|md5sum``

创建10个随机字母
~~~~~~~~~~~~~~~~

.. code:: shell

    echo $RANDOM|sha512sum|sed 's#[0-9]##g'|cut -c1-10

变量子串使用技巧
~~~~~~~~~~~~~~~~

生成随机密码
^^^^^^^^^^^^

.. code:: shell

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

`Back to TOC <#table-of-contents>`__

判断用户输入是否为数字
^^^^^^^^^^^^^^^^^^^^^^

.. code:: shell

        read -p "Please enter the amount of recharge: " re

        if [ -n "${re//[0-9]/}" ];then
            echo "input error"
            continue
        fi

    # 删除数字进行判断，判断是否为空

    # ---

    # 方法1：将数字以外的字符替换成空，如果跟本身相同，说明用户输入为数字

    [root@yjj ~]# [ "`echo 1231|sed -r 's#[^0-9]##g'`" = "1231" ]&&echo 0||echo 1
    0
    [root@yjj ~]# [ "`echo 123a|sed -r 's#[^0-9]##g'`" = "123a" ]&&echo 0||echo 1
    1

    # 方法2：使用expr，如果命令返回结果非零，则表示用户输入的不是数字

    [root@yjj ~]# expr 1 + a &>/dev/null
    [root@yjj ~]# echo $?
    2

计算字符串长度
~~~~~~~~~~~~~~

.. code:: shell

        string="I love you"
    方法一：
        echo ${#string}

    方法二：
        echo ${string}|wc -L

    方法三：
        expr length "${string}"

    方法四：
        awk '{print length($0)}' <<<$string

        awk '{print length}' <<<$string   ## $0可以省略
    方法五:
        functions内置函数，strstr

    # returns OK if $1 contains $2
    strstr() {
      [ "${1#*$2*}" = "$1" ] && return 1
      return 0
    }

命令拼接
~~~~~~~~

.. code:: shell

    [root@web 11]# chkconfig |awk '$1!~/crond|sshd|sysstat|network|rsyslog/{print "chkconfig",$1,"off"}'|bash

计算1+2+3+4+5+6+7+8+9+10
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

    [root@web scripts]# seq 10|awk '{a+=$1;b=b$1"+"}END{sub("+$","",b);print b"="a}'
    1+2+3+4+5+6+7+8+9+10=55

打印下面语句中字符数小于6的单词
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: shell

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

使用eval实现动态变量
--------------------

用变量值作新的变量名

.. code:: shell

    ➜  ~ refer_504_09="123"
    ➜  ~ time=`date +%H`
    ➜  ~ echo $time
    09
    ➜  ~ echo $refer_504_09
    123
    ➜  ~ a=`eval echo '$refer_504_'"$time"`
    ➜  ~ echo $a
    123

乘法口诀表
----------

.. code:: shell

    awk 'BEGIN{for(i=1;i<=9;i++){for(j=1;j<=i;j++){printf j"*"i"="i*j"\t"}printf "\n"}}'

    echo -ne "\033[47;30m`awk 'BEGIN{for(i=1;i<=9;i++){for(j=1;j<=i;j++){printf j"*"i"="i*j"\t"}printf "\n"}}'`\033[0m\n"

    seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("\033[47;30m%dx%d=%d%s", i, NR, i*NR, i==NR?"\033[0m\n":"\t")}'

    echo -e "\e[44;37;5m `awk 'BEGIN{for(i=1;i<10;i++) {for(k=1;k<=i;k++) {printf "%d%s%d%s%;}printf "\n"}}'` \e[0m "

    for i in {1..9}; do for j in `seq 1 $i`; do echo -ne "\033[47;30m${j}*${i}=$((j*i))\033[0m \t"; done; echo; done

    for((i=1;i<10;i++));do for((j=1;j<=i;j++))do printf "$j*$i=$((i*j))\t" ;done;printf "\n";done

圆周率计算
----------

.. code:: shell

    ➜  ~ echo "scale=1000; a(1)*4" | bc -l
    3.141592653589793238462643383279502884197169399375105820974944592307\
    81640628620899862803482534211706798214808651328230664709384460955058\
    22317253594081284811174502841027019385211055596446229489549303819644\
    28810975665933446128475648233786783165271201909145648566923460348610\
    45432664821339360726024914127372458700660631558817488152092096282925\
    40917153643678925903600113305305488204665213841469519415116094330572\
    70365759591953092186117381932611793105118548074462379962749567351885\
    75272489122793818301194912983367336244065664308602139494639522473719\
    07021798609437027705392171762931767523846748184676694051320005681271\
    45263560827785771342757789609173637178721468440901224953430146549585\
    37105079227968925892354201995611212902196086403441815981362977477130\
    99605187072113499999983729780499510597317328160963185950244594553469\
    08302642522308253344685035261931188171010003137838752886587533208381\
    42061717766914730359825349042875546873115956286388235378759375195778\
    18577805321712268066130019278766111959092164201988

批量修改文件名
--------------

awk、sed、rename批量修改文件名

.. code:: shell

    源文件名：
    stu_102999_1_hello.jpg
    stu_102999_2_hello.jpg
    stu_102999_3_hello.jpg
    stu_102999_4_hello.jpg
    stu_102999_5_hello.jpg

    修改后：
    stu_102999_1_.jpg
    stu_102999_2_.jpg
    stu_102999_3_.jpg
    stu_102999_4_.jpg
    stu_102999_5_.jpg

使用awk，gsub

.. code:: shell

    ls|awk '{print "mv "$0,$0}'|awk '{gsub("_hello","",$3)}1'

    ls|awk 'BEGIN{ORS=""}{print "mv",$0" ";gsub("_hello","",$0);print $0"\n"}'

    ls|awk '{$3=$2=$1;$1="mv";sub("_hello","",$3)}1'

直接使用print拼接

使用sed命令拼接

使用rename批量修改

其他
~~~~

-  环境变量的定义放到 /etc/bashrc #最后执行，不会被覆盖

文件字符集转换方法
------------------

iconv -f gb2312 -t UTF-8 2.html -o 2.utf8.html

.. code:: shell

    [root@centos scripts]# iconv --help
    Usage: iconv [OPTION...] [FILE...]
    Convert encoding of given files from one encoding to another.

     Input/Output format specification:
      -f, --from-code=NAME       encoding of original text
      -t, --to-code=NAME         encoding for output

     Information:
      -l, --list                 list all known coded character sets

     Output control:
      -c                         omit invalid characters from output
      -o, --output=FILE          output file
      -s, --silent               suppress warnings
          --verbose              print progress information

      -?, --help                 Give this help list
          --usage                Give a short usage message
      -V, --version              Print program version

    Mandatory or optional arguments to long options are also mandatory or optional
    for any corresponding short options.

    For bug reporting instructions, please see:
    <http://www.gnu.org/software/libc/bugs.html>.

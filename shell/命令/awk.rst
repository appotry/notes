awk
===

判断\ ``1-100``,如果数字为3的倍数, 输出\ ``Three``, 数字为5的倍数,
输出\ ``Five``,同时为3,5的倍数, 输出\ ``three and five``

.. code:: shell

    seq 100|awk '{if($0 % 3 == 0) print $0,"Three" ; \
    if($0 % 5 == 0 )print $0,"Five"; \
    if($0 % 3 == 0 && $0 % 5 == 0) print $0,"three and five"; \
    if($0 % 3 != 0 && $0 % 5 != 0) print $0,"0";}'

输出单双引号
------------

.. code:: shell

    # 双引号
    awk '{print "\""}'

    # 单引号
    echo 1 | awk '{print "\047" }'
    # 或者
    awk '{print "'\''"}'

awk 多个$用法
-------------

.. code:: shell

    [yjj@centos ~]$ cat a
    1 2 3 4 5
    1 2 3 a 5
    1 2 3 b 5
    [yjj@centos ~]$ awk '{print $$4}' a
    4
    1 2 3 a 5
    1 2 3 b 5

awk 字符集问题
--------------

.. code:: shell

    export LC_ALL=C
    echo {a..e} {A..E} {a..e}|xargs -n1|awk '/[A-Z]/'
    A
    B
    C
    D
    E

awk FIELDWIDTHS
---------------

.. code:: shell

    [root@centos ~]# echo "20161002"|awk -vFIELDWIDTHS="4 2 2" -vOFS="-" '{print $1,$2,$3}'
    2016-10-02

    [root@centos ~]# awk -v FIELDWIDTHS="4 2 2" -v OFS="-" '{print $1,$2,$3}'  <<<20160202
    2016-02-02

    [root@centos ~]# awk -vFIELDWIDTHS="4 2 2" '{printf "%s-%s-%s\n",$1,$2,$3}' <<<20160202
    2016-02-02

    [root@centos ~]#  sed -r 's@(.{4})(..)(..)@\1-\2-\3@' <<<"20161002"
    2016-10-02

案例
----

成绩统计案例
~~~~~~~~~~~~

.. code:: shell

    [yjj@centos awk]$ cat chengji
    yuwen shuxue yingyu
    10  10 10
    10 10 10
    10 10 10

    [yjj@centos awk]$ awk '{a=$1+$2+$3;print $0 "\t" (NR==1?"Total":a)}' chengji
    yuwen shuxue yingyu Total
    10 10 10 30
    10 10 10 30
    10 10 10 30

    [yjj@centos awk]$ awk '{NR==1;$4="Total"}NR>1{$4=$1+$2+$3}1' OFS="\t" chengji
    yuwen shuxue yingyu Total
    10 10 10 30
    10 10 10 30
    10 10 10 30

用awk如何自动填充空数据的列为最近的不为空的数据
-----------------------------------------------

用awk如何自动填充空数据的列为最近的不为空的数据？

比如以下文本：

.. code:: shell

    name1,1,21,address1
    name2,0,,
    name3,0,,
    name4,1,30,address4
    name5,0,24,address5
    name6,1,,
    name7,1,29,address7

其中name2、name3和name6的第三列和第四列都为空值，我想实现这些空值自动填充为它们上方的相应列不为空的数据，如下所示：

.. code:: shell

    name1,1,21,address1
    name2,0,21,address1
    name3,0,21,address1
    name4,1,30,address4
    name5,0,24,address5
    name6,1,24,address5
    name7,1,29,address7

.. code:: shell

    vi 1.txt

    name1,1,21,address1
    name2,0,,
    name3,0,,
    name4,1,30,address4
    name5,0,24,address5
    name6,1,,
    name7,1,29,address7

.. code:: shell

    # 1
    awk -F',' 'BEGIN{OFS=","}{if($1!=""&&$2!=""&&$3!=""&&$4!=""){a=$1;b=$2;c=$3;d=$4}else{if($1==""){$1=a;}if($2==""){$2=b;}if($3==""){$3=c;}if($4==""){$4=d}}print;}' 1.txt

    # 2
    awk -F","  '{if($3){b=null;for(i=3;i<=NF;i++){b=b","$i}print $0}else{$0=$0b;gsub(/,+/,",",$0);print $0}}' 1.txt

    # 3
    awk -F"," '{if(FNR==1){tmp3=$3;tmp4=$4;}if($3==null)$3=tmp3;if($4==null)$4=tmp4;tmp3=$3;tmp4=$4;a[FNR]=$1","$2","$3","$4; print a[FNR]}' 1.txt

    # 4
    awk -F"," 'BEGIN{OFS=","}{if($3){th=$3;fo=$4;print $0}else{print $1,$2,th,fo}}' 1.txt

    # 5
    awk -F, '{
    for(i = 1; i <= NF; i++) {
        a[i] = $i != "" ? $i : a[i];
    }
    printf("%s %s %s %s\n", a[1], a[2], a[3], a[4])}' 1.txt

    # 6
    awk -F, 'BEGIN{OFS=","}
    {
    for(i=1;i<5;++i)
      if(length($i)==0)
        $i = rec[i];
    split($0,rec);
    print
    }' 1.txt

复杂实现
~~~~~~~~

.. code:: shell

    #!/bin/bash
    awk '{print}' aa.txt | while read line
    do
            a1=`echo $line | awk -F , '{print $1}'`
            a2=`echo $line | awk -F , '{print $2}'`
            a3=`echo $line | awk -F , '{print $3}'`
            a4=`echo $line | awk -F , '{print $4}'`
            if [[ ! -z $a1 && ! -z $a2 && ! -z $a3 && ! -z $a1 ]];then
                    echo "$a1,$a2,$a3,$a4" >> bb.txt
                    b1=$a1
                    b2=$a2
                    b3=$a3
                    b4=$a4
            else
                    if [ -z $a1 ];then
                            a1=$b1
                    fi
                    if [ -z $a2 ];then
                            a2=$b2
                    fi
                    if [ -z $a3 ];then
                            a3=$b3
                    fi
                    if [ -z $a4 ];then
                            a4=$b4
                    fi
                    echo  "$a1,$a2,$a3,$a4" >> bb.txt
            fi
    done

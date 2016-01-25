<!-- TOC -->

- [1. Python练习](#1-python练习)
    - [1.1. 有四个数字: 1,2,3,4,能组成多少个互不相同且无重复数字的三位数?各是多少?](#11-有四个数字-1234能组成多少个互不相同且无重复数字的三位数各是多少)
    - [1.2. 企业发放的奖金根据利润提成,具体如下](#12-企业发放的奖金根据利润提成具体如下)
    - [1.3. 题目：在10000以内的数字找一个正整数，它加上100和加上268后都是一个完全平方数，请问该数是多少？](#13-题目在10000以内的数字找一个正整数它加上100和加上268后都是一个完全平方数请问该数是多少)
    - [1.4. 输入某年某月某日，判断这一天是这一年的第几天？](#14-输入某年某月某日判断这一天是这一年的第几天)
    - [1.5. 输入三个整数x,y,z，请把这三个数由小到大输出。](#15-输入三个整数xyz请把这三个数由小到大输出)
    - [1.6. 斐波那契数列](#16-斐波那契数列)
    - [1.7. 将一个列表的数据复制到另一个列表中。](#17-将一个列表的数据复制到另一个列表中)
    - [1.8. 输出 9*9 乘法口诀表。](#18-输出-99-乘法口诀表)
    - [1.9. 暂停一秒输出。](#19-暂停一秒输出)
    - [1.10. 暂停一秒输出，并格式化当前时间。](#110-暂停一秒输出并格式化当前时间)
    - [1.11. 古典问题：有一对兔子，从出生后第3个月起每个月都生一对兔子，小兔子长到第三个月后每个月又生一对兔子，假如兔子都不死，问每个月的兔子总数为多少？](#111-古典问题有一对兔子从出生后第3个月起每个月都生一对兔子小兔子长到第三个月后每个月又生一对兔子假如兔子都不死问每个月的兔子总数为多少)
    - [1.12. 判断101-200之间有多少个素数，并输出所有素数。](#112-判断101-200之间有多少个素数并输出所有素数)
    - [1.13. 打印出所有的"水仙花数"](#113-打印出所有的水仙花数)
    - [1.14. 将一个正整数分解质因数。例如：输入90,打印出90=2*3*3*5。](#114-将一个正整数分解质因数例如输入90打印出902335)

<!-- /TOC -->

# 1. Python练习

[http://www.runoob.com/python/python-100-examples.html](http://www.runoob.com/python/python-100-examples.html)

## 1.1. 有四个数字: 1,2,3,4,能组成多少个互不相同且无重复数字的三位数?各是多少?

> 分析: 列出所有可能,去掉不满足条件的

```Python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 11:14 AM
# @Author  : yang

count = 0
for i in range(1,5):
    for j in range(1,5):
        for k in range(1,5):
            if (i != k ) and i !=j and j != k:
                print("%s%s%s" % (i,j,k))
                count += 1
print("总数量: ", count)
```

## 1.2. 企业发放的奖金根据利润提成,具体如下

利润(I)低于或等于10万元时，奖金可提10%；利润高于10万元，低于20万元时，低于10万元的部分按10%提成，高于10万元的部分，可提成7.5%；20万到40万之间时，高于20万元的部分，可提成5%；40万到60万之间时高于40万元的部分，可提成3%；60万到100万之间时，高于60万元的部分，可提成1.5%，高于100万元时，超过100万元的部分按1%提成，从键盘输入当月利润I，求应发放奖金总数？

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 11:26 AM
# @Author  : yang

i = int(input("请输入利润: "))

profit = [1000000,600000,400000,200000,100000,0]
rat = [0.01,0.15,0.03,0.05,0.075,0.1]
r = 0
for n in range(0,6):
    if i > profit[n]:
        r += (i - profit[n]) * rat[n]
        i = profit[n]
print("奖金: ",r)
```

## 1.3. 题目：在10000以内的数字找一个正整数，它加上100和加上268后都是一个完全平方数，请问该数是多少？

> 数学上，平方数，或称完全平方数，是指可以写成某个整数的平方的数，即其平方根为整数的数。 例如，9 = 3 × 3，它是一个平方数。 平方数也称正方形数，若n 为平方数，将 n 个点排成矩形，可以排成一个正方形。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 11:50 AM
# @Author  : yang

import math
for i in range(1,10000):
    #if math.sqrt(i + 100) % 1 ==  math.sqrt(i + 268) % 1:
    if math.ceil(math.sqrt(i + 100)) ==  math.sqrt(i + 100) and math.ceil(math.sqrt(i + 268)) == math.sqrt(i + 268):
        print(i)
```

## 1.4. 输入某年某月某日，判断这一天是这一年的第几天？

1. 年份能被4整除；
2. 年份若是 100 的整数倍的话需被400整除，否则是平年。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 1:51 PM
# @Author  : yang

year = int(input("year: "))
month = int(input("month: "))
day = int(input("day: "))
sum = day

days = [31,28,31,30,31,30,31,31,30,31,30,31]

for i in range(0,month - 1):
    sum += days[i]

leap = 0
if (year % 400 == 0) or (year % 4 == 0 and year % 100 != 0):
    leap = 1
if (leap == 1) and (month > 2):
    sum += 1
    print("%s 是闰年" % (year))

print("It is the %sth day of %s/%s/%s" % (sum,year,month,day))
```

## 1.5. 输入三个整数x,y,z，请把这三个数由小到大输出。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 2:27 PM
# @Author  : yang

l = []
for i in range(3):
    x = int(input("请输入一个整数: "))
    l.append(x)
l.sort()
print(l)
```

## 1.6. 斐波那契数列

> 斐波那契数列（Fibonacci sequence），又称黄金分割数列，指的是这样一个数列：0、1、1、2、3、5、8、13、21、34、……。

递归,输出第n个数

```Python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 2:27 PM
# @Author  : yang

def fib(n):
    if n == 0 or n == 1:
        return n
    else :
        return fib(n-2) + fib(n-1)

print(fib(10))
```

输出一个数列

```Python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 2:27 PM
# @Author  : yang

def fib(n):
    if n == 0 :
        return [0]
    if n == 1:
        return [0,1]
    fibs = [0,1]
    for i in range(2,n):
        fibs.append(fibs[i-1] + fibs[i-2])
    return fibs


print(fib(10))
```

## 1.7. 将一个列表的数据复制到另一个列表中。

> 使用列表[:]

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 25/04/2017 2:27 PM
# @Author  : yang

a = [1,2,3]
b = a[:]
print(b)
```

```python
>>> a=[1,2,3]

>>> b=a.copy()
>>> b
[1, 2, 3]
```

## 1.8. 输出 9*9 乘法口诀表。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

for i in range(1,10):
    print()
    for j in range(1,i+1):
        print(i,"*",j,"=",i*j,"\t",end="")
```

## 1.9. 暂停一秒输出。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
mydict = {"var1" : 1 , "var2" : 2}
for key,value in dict.items(mydict):
    print(key,value)
    time.sleep(1)
```

## 1.10. 暂停一秒输出，并格式化当前时间。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
print(time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())))

time.sleep(1)

print(time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())))

```

## 1.11. 古典问题：有一对兔子，从出生后第3个月起每个月都生一对兔子，小兔子长到第三个月后每个月又生一对兔子，假如兔子都不死，问每个月的兔子总数为多少？

```python

```

## 1.12. 判断101-200之间有多少个素数，并输出所有素数。

> 程序分析：判断素数的方法：只能被1和自身整除

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

#!/usr/bin/env python
# -*- coding: utf-8 -*-

l = []
for i in range(101,201):
    count = 0
    for j in range(2,i+1):
        if i % j == 0:
            count += 1
    if count == 1:
        l.append(i)

print(l)
print("素数的数量是: ",len(l))
```

## 1.13. 打印出所有的"水仙花数"

> 所谓"水仙花数"是指一个三位数，其各位数字立方和等于该数本身。例如：153是一个"水仙花数"，因为153=1的三次方＋5的三次方＋3的三次方。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

for i in range(100,1000):
    a = i // 100
    b = i // 10 % 10
    c = i % 10
    if (a ** 3 + b ** 3 + c ** 3 == i):
        print(i)
```

## 1.14. 将一个正整数分解质因数。例如：输入90,打印出90=2*3*3*5。

```python

```


# python

> Updated: 2017-10-22

[离线阅读参考这个](https://yangjinjie.github.io/notes/)

参考链接

- [Django documentation](https://docs.djangoproject.com/en/1.11/)
- [GitHub ansheng's blog](https://github.com/anshengme/blog)
- [http://blog.ansheng.me/](http://blog.ansheng.me/)
- [自强学堂 Django](http://code.ziqiangxuetang.com/django/django-tutorial.html)
- [自强学堂 Python](http://code.ziqiangxuetang.com/python/python-tutorial.html)

## 安装Python

### Mac升级python

安装 `python 3.x`

1. 方法一: 官网下载需要安装的版本 -> 安装
2. 方法二: 如果安装了Homebrew，直接通过命令`brew install python3`安装即可

命令行python 然后狂按tab键，会显示很多python，选择需要的，做一个别名，结束

    ➜  ~ alias python='python3'

永久生效，请写到配置文件

或者直接使用 `python3` 运行 `python3.x`

### 编译安装

#### 安装依赖

> Centos

```shell
yum install gcc -y
yum install openssl-devel
```

#### 下载Python源码包

```shell
wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
xz -d Python-3.6.4.tar.xz
tar xf Python-3.6.4.tar
```

#### 编译, 安装

```shell
cd Python-3.6.4
./configure && make && make install
```

# Quickstart for Python/WSGI applications

## 安装uWSGI支持Python

uWSGI使用C编写, 所以需要C编译器(比如gcc或clang)以及Python开发包

基于Debian的发行版执行如下命令

    apt-get install build-essential python-dev

### 安装uWSGI

安装方法

- 通过pip
    - `pip install uwsgi`
- 通过curl
    - `curl http://uwsgi.it/install | bash -s default /tmp/uwsgi` (这将安装`uWSGI`二进制包到`/tmp/uwsgi`,可自行修改).
- 源码安装

```shell
wget https://projects.unbit.it/downloads/uwsgi-latest.tar.gz
tar zxvf uwsgi-latest.tar.gz
cd <dir>
make
```

## 部署WSGI应用

从以下示例开始, 将内容保存到`foobar.py`

```python
def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return [b"Hello World"]
```

### Deploy it on HTTP port 9090

如果前端有负载均衡等, 不要使用`--http`, 使用`--http-socket`

    uwsgi --http :9090 --wsgi-file foobar.py

### 增加并发和监控

默认uWSGI使用单进程, 单线程

可以使用`--processes`参数启动多进程, 使用`--threads`参数启动多线程.

    uwsgi --http :9090 --wsgi-file foobar.py --master --processes 4 --threads 2

如上命令将启动4个进程(每个进程两个线程), 一个master进程(当进程死掉的时候, 重生他们)

```shell
uwsgi --http :9090 --wsgi-file foobar.py --master --processes 4 --threads 2 --stats 127.0.0.1:9191
```

`--stats`参数, 可以允许我们使用JSON格式导出uWSGI的状态

`curl 127.0.0.1:9191`即可获取相关信息

同时提供一个类似`top`命令的工具监控,`uwsgitop`(使用pip安装).

### 使用Nginx代理

```shell
location / {
    include uwsgi_params;
    uwsgi_pass 127.0.0.1:3031;
}
```

使用本地uwsgi协议重新启动 uWSGI.

```shell
uwsgi --socket 127.0.0.1:3031 --wsgi-file foobar.py --master --processes 4 --threads 2 --stats 127.0.0.1:9191
```

如果代理服务器使用HTTP, 那么uWSGI也需要使用HTTP协议(这个参数不同于`--http`, 它将通过自身产生一个代理)

```shell
uwsgi --http-socket 127.0.0.1:3031 --wsgi-file foobar.py --master --processes 4 --threads 2 --stats 127.0.0.1:9191
```

### Automatically starting uWSGI on boot

查阅官方文档

[WSGIquickstart](http://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html)

## 部署Flask

使用如下命令开始, `myflaskapp.py`

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "<span style='color:red'>I am app 1</span>"
```

Flask的出口是一个app的WSGI函数(在这里我们称为"application"),我们需要通知uWSGI使用它

```shell
uwsgi --socket 127.0.0.1:3031 --wsgi-file myflaskapp.py --callable app --processes 4 --threads 2 --stats 127.0.0.1:9191
```

仅仅新增了`--callable`参数

### Deploying web2py

一个比较受欢迎的选择, 编写一个uWSGI配置文件, `uwsgi.ini`

```shell
[uwsgi]
http = :9090
chdir = /root/foobar
module = myflaskapp
callable = app
# 使用虚拟环境
virtualenv = /root/.pyenv/versions/uwsgi
master = true
processes = 8
```

执行命令 `uwsgi uwsgi.ini`, 使用浏览器访问9090端口

## 完整配置
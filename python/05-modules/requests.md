# requests模块

[https://github.com/kennethreitz/requests](https://github.com/kennethreitz/requests)

[http://docs.python-requests.org/en/master/](http://docs.python-requests.org/en/master/)

## 安装requests

通过pip安装

    pip3 install requests

或者下载源码安装

    git clone https://github.com/kennethreitz/requests.git
    cd requests
    python setup.py install

## 发送请求与传递参数

```python
>>> import requests
>>> r = requests.get(url='http://www.baidu.com')
>>> print(r.status_code) # 返回状态吗
200
>>> r = requests.get(url='http://dict.baidu.com/s',params={'wd':'python'})
>>> print(r.url)
http://dict.baidu.com/s?wd=python
>>> print(r.text) # 打印解码后返回的数据
```

其他方法

```Python
很简单吧！不但GET方法简单，其他方法都是统一的接口样式哦！

requests.get('127.0.0.1') #GET请求
requests.post(“http://xxx.org/post”) #POST请求
requests.put(“http://xxx.org/put”) #PUT请求
requests.delete(“http://xxx.org/delete”) #DELETE请求
requests.head(“http://xxx.org/get”) #HEAD请求
requests.options(“http://xxx.org/get”) #OPTIONS请求
```

上面这些HTTP方法,对于WEB一般只支持GET和POST,有一些还支持HEAD方法

POST发送JSON数据

```Python
import requests
import json

r = requests.post('https://api.github.com/some/endpoint', data=json.dumps({'some': 'data'}))
print(r.json())
```

定制header

```Python
import requests
import json

data = {'some': 'data'}
headers = {'content-type': 'application/json',
           'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100101 Firefox/22.0'}

r = requests.post('https://api.github.com/some/endpoint', data=data, headers=headers)
print(r.text)
```

## response对象

使用requests方法后,会返回一个response对象,其存储了服务器响应的内容,如r.text,r.status_code

获取文本方式的响应实例:当你访问r.text的时候,会使用期响应的文本编码进行解码,并且你可以修改其编码让r.text使用自定义的编码进行解码.
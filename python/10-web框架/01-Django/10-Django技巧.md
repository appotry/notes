# Django技巧

## 判断用户是否登录

```python
if request.user.is_authenticated():
    # Do something for authenticated users.
else:
    # Do something for anonymous users.
```

## 自定义admin界面

[官方文档](https://docs.djangoproject.com/en/1.11/ref/contrib/admin/)

[Django admin 项目 https://djangopackages.org/grids/g/admin-interface/](https://djangopackages.org/grids/g/admin-interface/)

[参考 http://blog.csdn.net/hshl1214/article/details/45676409](http://blog.csdn.net/hshl1214/article/details/45676409)

[http://blog.csdn.net/clh604/article/details/9365961](http://blog.csdn.net/clh604/article/details/9365961)

[权限控制 http://blog.csdn.net/xtmyd/article/details/53813091](http://blog.csdn.net/xtmyd/article/details/53813091)

- 创建项目下`templates/admin`目录, 并设置
- 拷贝`site-packages/django/contrib/admin/templates/admin`目录下对应模板文件到如上目录
- 修改`templates/admin`下对应模板文件, 重新加载即可看到效果

如果需要添加`admin`为前缀的url, 只需要配置`urls.py`即可(放在系统匹配url规则之前).

```python
urlpatterns = [
    url(r'^admin/export_to_xlsx/$', userinfo_views.export_to_xlsx),
    url(r'^admin/update_records/$', userinfo_views.update_records),
    url(r'^admin/import_from_xlsx/$', userinfo_views.import_from_xlsx),
    url(r'^admin/', admin.site.urls),
]
```

### 设置templates

```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

## Django admin 上传下载

### Django 上传文件

使用 `request.FILES.get('xlsx')` 获取文件对象 'xlsx',为`html`中`name`属性

直接使用`obj.name`获取的名字, 可能不安全, 比如存在`../../../`这样的路径, 所以需要处理

```python
def import_from_xlsx(request):
    if request.method == "POST":
        path = "uploads"
        if not os.path.exists(path):
            os.makedirs(path)
        try:
            obj = request.FILES.get('xlsx')
            name = os.path.splitext(obj.name)[0]
            postfix = os.path.splitext(obj.name)[1]

            file_name = os.path.join(path, "{}-{}{}".format(name, time.strftime("%Y%m%d%H%M%S"), postfix))
            print(file_name)

            # 写文件, 其他地方自行修改
            f = open(file_name, 'wb')
            for chunk in obj.chunks():
                f.write(chunk)
            f.close()

            manager = Manager()

            user_list, l = manager.check_from_xlsx(file_name)
            return render(request, 'admin/check_user.html', {'user_list': user_list,'length':l, 'file_name':file_name })

        except Exception as e:
            raise e

    elif request.method == "GET":
        file_name = request.GET.get('file_name')
        if file_name is not None:
            print("get")
            manager = Manager()
            manager.auth_from_xlsx(file_name)
            return redirect('/admin/update_records')
        else:
            raise ValueError('文件错误')
```

### Django下载文件

#### html

```html
<div class="row">
      <div class="col-md-8 col-md-offset-2">
          <br>
          <P>第一种方法，直接把链接地址指向要下载的静态文件，在页面中点击该链接，可以直接打开该文件，在链接上点击右键，选择“另存为”可以保存该文件到本地硬盘。
             此方法只能实现静态文件的下载，不能实现动态文件的下载。</P>
          <a href="{% url 'media' 'uploads/11.png' %}">11.png</a>
          <br>
          <br>
          <p>第二种方法，将链接指向相应的view函数，在view函数中实现下载功能，可以实现静态和动态文件的下载。</p>
          <a href="{% url 'course:download_file' %}">11.png</a>
          <br>
          <br>
          <br>
          <p>第三种方法，与第二种方法类似，利用按钮的响应函数实现文件下载功能。</p>
          <label> 11.png</label><button onclick="window.location.href='{% url 'course:download_file' %}'">Download</button>
      </div>
  </div>
```

#### 视图函数

```python
from django.http import StreamingHttpResponse
from django.utils.http import urlquote

def export_to_xlsx(request):
    def file_iterator(file_name, chunk_size=512):
        # 读取 excel 需要使用 rb
        with open(file_name, 'rb') as f:
            while True:
                c = f.read(chunk_size)
                if c:
                    yield c
                else:
                    break
    dirpath = '/Users/yjj'
    xlsx_filename = 'xxx-' + time.strftime('%Y-%m-%d-%H%M%S') + '.xlsx'
    xlsx_path = os.path.join(dirpath, xlsx_filename)

    response = StreamingHttpResponse(file_iterator(xlsx_path))
    response['Content-Type'] = 'application/octet-stream'
    # 中文文件名, 使用 urlquote
    response['Content-Disposition'] = "attachment; filename={0}".format(urlquote(xlsx_filename))

    return response
```

## Django自定义action

[http://blog.csdn.net/tulip527/article/details/8737835](http://blog.csdn.net/tulip527/article/details/8737835)

## Django中的csrf

[http://www.cnblogs.com/chenchao1990/p/5339779.html](http://www.cnblogs.com/chenchao1990/p/5339779.html)

## 关闭Debug之后, 静态文件的问题

如果是直接使用Django的runserver `--insecure`

- `python manage.py runserver 0.0.0.0:8000 --insecure`

使用Nginx, Apache等提供静态文件
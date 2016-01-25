# 使用Python优雅的实现switch

[https://www.zhihu.com/question/50498770?sort=created](https://www.zhihu.com/question/50498770?sort=created)

## 优雅实现

运行效率不会变快, 但是代码容易维护

```python
_registered_actions = {}

def action(name):
    def decorator(f):
        _registered_actions[name] = f
        return f
    return decorator

@action("getInfo")
def get_info(data):
    ...

@action("changeName")
def change_name(data):
    ...

def do_action(action_name, data):
    try:
        f = _registered_actions[action_name]
    except KeyError:
        return json.dumps(...)
    else:
        f(data)
        ...
```

## 2

```python
在一个函数里用dict的{key:func}这种方式尚可，但用lambda 可读性就很惆怅了。。

另外这个dict建议放在类定义里，

首先在类定义里加上

    allow_methods={"method1","method2"} #构造一个集合

具体调用的时候

if func_name in self.allow_methods:
    func = getattr(self,"on_"+func_name)
    func(...)
```
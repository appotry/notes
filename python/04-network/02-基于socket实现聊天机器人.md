# 基于socket实现聊天机器人

<!-- TOC -->

- [基于socket实现聊天机器人](#基于socket实现聊天机器人)
    - [第一份](#第一份)
        - [server](#server)
        - [client](#client)
    - [第二份](#第二份)
        - [server](#server-1)
        - [client](#client-1)

<!-- /TOC -->

## 第一份

### server

1. 创建一个socket
2. 监听地址
3. 等待客户端发送消息
4. 回应
5. 关闭

```python
import socket

server = socket.socket()

server.bind(('localhost',60004))
server.listen()

print("等待小可爱上线...")
conn,addr = server.accept()
print("你的小可爱上线了...")
count = 0
while True:
    message = conn.recv(1024)
    print("recv: ",message.decode('utf-8'))
    if not message:
        print("你的小可爱断开连接了...")
        break
    conn.send(message.upper())
    count += 1
    if count > 10 :break

server.close()

```

### client

1. 创建一个socket
2. 连接服务器
3. 发送消息
4. 接收来自服务端的回复
5. 关闭

```python
import socket

client = socket.socket()

client.connect(('localhost',60004))

while True:
    message = input("输入q退出>> ").strip()
    if message == 'q':
        break
    else:
        client.send(message.encode('utf-8'))
    data = client.recv(1024)
    print(data.decode('utf-8'))

client.close()

```

## 第二份

通过socket实现局域网内的聊天工具

### server

service.py内容

```python
#!/usr/bin/env python
# _*_ coding:utf-8 _*_

import socket

# 创建一个对象
sk = socket.socket()
# 绑定允许连接的IP地址和端口
sk.bind(('127.0.0.1',6054,))
# 服务端运行后,限制客户端连接的数量,如果超过五个连接,第六个连接来的时候直接断开第六个
sk.listen(5)

while True:
    # 会一直阻塞,等待接收客户端的请求,如果有客户端连接会获取两个值,conn=创建的连接,address=客户端的IP和端口
    conn,address = sk.accept()
    # 当用户连接过来的时候就给用户发送一条信息,在python3里面需要把发送的内容转换为字节
    conn.sendall(bytes("你好",encoding="utf-8"))

    while True:

        print("正在等待Client输入内容......")
        # 接收客户端发送过来的内容
        ret_bytes = conn.recv(1024)
        # 转换成字符串类型
        ret_str = str(ret_bytes,encoding="utf-8")
        # 输出用户发送过来的内容
        print(ret_str)
        # 如果用户输入的是q
        if ret_str == "q":
            # 则退出循环,等待下个用户输入
            break
        # 给客户端发送内容
        inp = input("Service请输入要发送的内容>>>")
        conn.sendall(bytes(inp,encoding="utf-8"))
```

### client

client.py的内容

```python
#!/usr/bin/env python
# _*_ coding:utf-8 _*_

import socket

# 创建一个socket对象
obj = socket.socket()
# 制定服务端的IP地址和端口
obj.connect(('127.0.0.1',6054,))
# 阻塞,等待服务端发送内容,接受服务端发送过来的内容,最大接受1024字节
ret_bytes = obj.recv(1024)
# 因为服务端发送过来的是字节,所以我们需要把字节转换为字符串进行输出
ret_str = str(ret_bytes,encoding="utf-8")
# 输出内容
print(ret_str)

while True:
    # 当进入连接的时候,提示让用户输入内容
    inp = input("Client -> 请输入要发送的内容>>>")
    # 如果输出q则退出
    if inp == "q":
        # 把q发送给服务端
        obj.sendall(bytes(inp,encoding="utf-8"))
        # 退出当前while
        break
    else:
        # 否则就把用户输入的内容发送给用户
        obj.sendall(bytes(inp,encoding="utf-8"))
        # 等待服务端响应
        print("正在等待Server输入内容......")
        # 获取服务端发送过来的结果
        ret = str(obj.recv(1024),encoding="utf-8")
        # 输出结果
        print(ret)
# 连接完成之后关闭连接
obj.close()
```

![python-029-1](http://oi480zo5x.bkt.clouddn.com/python-029-1.jpg)


socket server实现多并发
=======================

简单实现
--------

server

.. code:: python

    import socketserver

    class MyServer(socketserver.BaseRequestHandler):

        def handle(self):
            print("客户端 %s 连接成功" % self.client_address[0])
            while True:
                self.data = self.request.recv(1024).strip()
                print("{} {} wrote:".format(self.client_address[0],self.client_address[1]))
                print(self.data)
                if not self.data:
                    print(self.client_address,"断开了")
                    break
                self.request.send(self.data.upper())


    if __name__ == '__main__':
        HOST,PORT = '127.0.0.1',60006
        server = socketserver.ThreadingTCPServer((HOST,PORT),MyServer)
        print("等待客户端...")
        server.serve_forever()

client

.. code:: python

    import socket

    client = socket.socket()

    client.connect(('127.0.0.1',60006))

    while True:
        message = input(">> ").strip()

        client.send(message.encode())
        up = client.recv(1024)
        print(up.decode())

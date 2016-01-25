# 发送邮件

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author  : yang
# @version : 0.2

import smtplib
import time
import os
from email.mime.text import MIMEText
from email.utils import formataddr
from email.mime.multipart import MIMEMultipart


class MyEmail(object):
    def __init__(self, mail_sender=None, pwd=None, content=None, file_path=None, subject=None,
                 to_list=None, cc_list=None, bcc_list=None):
        """

        :param mail_sender: 发件人
        :param pwd: 发件人密码
        :param content: 邮件内容
        :param file_path: 文件列表
        :param subject: 主题
        :param to_list: 收件人列表
        :param cc_list: 抄送人列表
        :param bcc_list: 按送人列表
        """
        self.mail_sender = mail_sender
        self.password = pwd

        self.to_list = [] if to_list is None else self.to_list = to_list
        self.cc_list = [] if cc_list is None else self.cc_list = cc_list
        self.bcc_list = [] if bcc_list is None else self.bcc_list = bcc_list
        self.file_path = [] if file_path is None else self.file_path = file_path

        self.subject = subject
        self.filename = os.path.basename(self.file_path)
        self.content = content

        self.msg = self.generate_mail()

    def generate_mail(self):
        """
        生成邮件内容
        :return:
        """
        msg = MIMEMultipart()

        msg['Subject'] = self.subject
        # 发件人,收件人,主题等等
        msg['From'] = self.mail_sender
        # 收件人
        if self.to_list:
            msg['To'] = ";".join(self.to_list)
        # 抄送
        if self.cc_list:
            msg['CC'] = ";".join(self.cc_list)
        # 暗送
        if self.bcc_list:
            msg['bcc'] = ";".join(self.bcc_list)
        # 邮件正文
        if self.content:
            body = MIMEText(self.content)
            msg.attach(body)
        # 附件
        if isinstance(self.file_path, list):
            for file in self.file_path:
                att = MIMEText(open(file, 'rb').read(), 'base64', 'utf-8')
                att["Content-Type"] = 'application/octet-stream'
                # print(self.filename)
                att.add_header('Content-Disposition', 'attachment', filename=('gbk', '', self.filename))
                msg.attach(att)

        return msg

    def send_email(self,smtp_server="smtp.exmail.qq.com", ssl=True, port=465):
        """
        发送邮件
        :param smtp_server: smtp服务器
        :param ssl: 默认使用ssl
        :param port: 端口
        :return:
        """
        try:
            if ssl:
                server = smtplib.SMTP_SSL(smtp_server, port)
            else:
                server = smtplib.SMTP(smtp_server, port)
            server.login(self.mail_sender, self.password)
            server.sendmail(self.mail_sender, self.to_list + self.cc_list + self.bcc_list, self.msg.as_string())
            server.quit()
            print('success')
        except Exception as e:
            print(e)


if __name__ == '__main__':
    DATABASE_BRAVE = {'smtp_server': 'smtp.163.com', 'port': 25, 'username': 'brxxx@163.com', 'password': 'xxxxxxx00'}
    username = DATABASE_BRAVE['username']
    password = DATABASE_BRAVE['password']

    subject = 'xxx-' + time.strftime('%Y-%m-%d-%H%M%S')

    content = '邮件内容 xxx'
    file_path = ["/Users/xxx/Pictures/哈哈.jpg",]
    to_list = ['493535459@qq.com',]
    # cc_list = ['xxx@qq.com']
    # bcc_list = ['xxx@qq.com',]

    my_email = MyEmail(
        mail_sender=username, pwd=password,
        content=content,
        file_path=file_path, subject=subject,
        to_list=to_list,
        # cc_list=cc_list,
        # bcc_list=bcc_list
    )
    my_email.send_email(smtp_server=DATABASE_BRAVE['smtp_server'], port=DATABASE_BRAVE['port'], ssl=True)
```
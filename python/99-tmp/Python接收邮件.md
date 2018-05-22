# Python接收邮件

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 08/12/2017 2:15 PM
# @Author  : yang

import sys
import re
import email
from imapclient import IMAPClient


def set_flag_seen(message_id, account_info):
    """
    # 设置邮件为已读取
    :param message_id: 消息id列表
    :return:
    """
    imapObj = IMAPClient(account_info['imap_server'])
    imapObj.login(username=account_info['username'], password=account_info['password'])
    imapObj.select_folder('INBOX', readonly=False)

    # 标记为已读
    imapObj.add_flags(message_id, br'\Seen')
    print("set_flag_seen")


def get_unseen_mail(server):
    """
    获取状态为 unseen 的邮件
    :param server: IMAPClient
    :return:
    """
    server.select_folder('INBOX', readonly=True)
    result = server.search('UNSEEN')
    if not result:
        sys.exit(0)

    print(result)

    # 使用fetch()函数收取邮件
    msgdict = server.fetch(result, [b'BODY.PEEK[]'])
    for message_id, message in msgdict.items():
        print(message, message_id)
        print(message[b'BODY[]'])

        e = email.message_from_string(message[b'BODY[]'].decode()) # 生成Message类型
        # print(e)

        subject = email.header.make_header(email.header.decode_header(e['SUBJECT'])) #必须保证包含subject
        # <class 'email.header.Header'>
        mail_from = email.header.make_header(email.header.decode_header(e['From']))
        # 发件人邮箱
        mail_from_just_mail = re.search(r'(?!.*<).*(?=>)', str(mail_from)).group()

        print('---------')
        # 解析邮件正文
        maintype = e.get_content_maintype()
        if maintype == 'multipart':
            for part in e.get_payload():
                if part.get_content_maintype() == 'text':
                    mail_content = part.get_payload(decode=True).strip()
        elif maintype == 'text':
            mail_content = e.get_payload(decode=True).strip()
        # 此时，需要把content转化成中文，利用如下方法：
        try:
            mail_content = mail_content.decode('gbk')
        except UnicodeDecodeError:
            print('decode error')
            sys.exit(1)
        else:
            print('new message')
            print('From: ', mail_from_just_mail)
            print('Subject: ', subject)

            print('-' * 10, 'mail content', '-' * 10)
            print(mail_content.replace('<br>', '\n'))
            print('-' * 10, 'mail content', '-' * 10)


if __name__ == '__main__':

    EMAIL_ACCOUNT_INFO = {
        'imap_server': 'imap.exmail.qq.com',
        'username': 'username',
        'password': 'password'
    }

    server = IMAPClient(EMAIL_ACCOUNT_INFO['imap_server'])
    server.login(
        username=EMAIL_ACCOUNT_INFO['username'],
        password=EMAIL_ACCOUNT_INFO['password']
    )

    get_unseen_mail(server)
```

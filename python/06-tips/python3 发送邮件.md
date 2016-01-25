# python3 发送邮件

[email 模块](https://docs.python.org/3.5/library/email-examples.html)

```python
import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr
from email.mime.multipart import MIMEMultipart


class MyEmail(object):
    def __init__(self,mail_sender=None, pwd=None, content=None, file_path=None, subject=None,
                 to_list=[], cc_list=[], bcc_list=[]):
        """

        :param mail_sender:
        :param password:
        :param content:
        :param file_path:
        :param subject:
        :param to_list:
        :param cc_list:
        :param bcc_list:
        """
        self.mail_sender = mail_sender
        self.password = pwd
        self.to_list = to_list
        self.cc_list = cc_list
        self.bcc_list = bcc_list
        self.subject = subject
        self.file_path = file_path
        self.filename = os.path.basename(self.file_path)
        self.content = content

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
        if self.file_path:
            att = MIMEText(open(self.file_path, 'rb').read(), 'base64', 'utf-8')
            att["Content-Type"] = 'application/octet-stream'
            att.add_header('Content-Disposition', 'attachment', filename=('gbk', '', self.filename))
            msg.attach(att)


        return msg.as_string()

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
            server.login(self.mail_sender,self.password)
            server.sendmail(self.mail_sender, self.to_list + self.cc_list + self.bcc_list, self.generate_mail())
            server.quit()
            print('success')
        except Exception as e:
            print(e)


if __name__ == '__main__':
    import time
    DATABASE_BRAVE = { "smtp_server":"smtp.163.com","port":25,"username": 'brxxx@163.com',"password": 'xxxxxxx00'  }
    # 用户名
    username = DATABASE_BRAVE['username']
    # 密码
    password = DATABASE_BRAVE['password']
    # 主题
    subject = "权限表-" + time.strftime('%Y-%m-%d-%H%M%S')
    # 邮件内容
    content = '邮件内容 xxx'
    # 上传文件内容
    file_path = "~/Documents/notes/gh-pages_oam_create.sh"
    # 收件人
    to_list = ['mxxe@xx.com',]
    # 抄送人
    cc_list = ['xx4159@qq.com']
    # 暗送人
    bcc_list = ['493535459@qq.com',]

    myemail = MyEmail(
        mail_sender=username, pwd=password,
        content=content,
        file_path=file_path, subject=subject,
        to_list=to_list,
        cc_list=cc_list,
        bcc_list=bcc_list
    )
    # myemail.send_email()
    myemail.send_email(smtp_server=DATABASE_BRAVE['smtp_server'],port=DATABASE_BRAVE['port'],ssl=False)
```

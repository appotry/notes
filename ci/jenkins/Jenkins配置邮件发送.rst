Jenkins配置邮件发送
===================

安装“`Email Extension Plugin <http://wiki.jenkins-ci.org/display/JENKINS/Email-ext+plugin>`__” 插件
---------------------------------------------------------------------------------------------------

系统管理-> 管理插件 -> 安装 “Email Extension Plugin” 这个插件

配置系统 Email Extension Plugin 插件
------------------------------------

系统管理-> 系统设置 ->找到“Extended E-mail Notification”

具体配置参数：

.. code:: shell

    SMTP server smtp.exmail.qq.com

        ...点击**高级**...(配置发信)

    勾选"Use SMTP Authentication"

    User Name brave0517@163.com
    Password xxx
    Use SSL  ☑️
    SMTP  Port 465
    Charset UTF-8
    Default Content Type  选择“Plain Text(text/plain)”
    Default Recipients brave0517@163.com
    Default Subject

        Default Subject：构建通知:$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!

    Default Content

.. code:: txt

      (本邮件是程序自动下发的，请勿回复！)
      项目名称：$PROJECT_NAME
      构建编号：$BUILD_NUMBER
      git版本号：${GIT_REVISION}
      构建状态：$BUILD_STATUS
      触发原因：${CAUSE}
      构建日志地址：${BUILD_URL}console
      构建地址：$BUILD_URL

点击 “Apply” -> “保存“

配置项目（只需要在发送邮件通知的项目配置）
------------------------------------------

增加一个构建后操作选择“Email Extension Plugin”

具体配置参数：

Project Recipient List

493535459@qq.com,xxx@qq.com （收件人，是一个列表，逗号分割）

点击“Advanced Settins…”

点击“Add Trigger”分别选择 “Success”,“Failure - Any”, “Not Built”
3个触发器（成功，失败，都会发邮件）

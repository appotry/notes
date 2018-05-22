使用 Jenkins 持续集成 GitBook
================================

准备：
------

系统管理 -> 系统设置 -> 浏览器搜索“Publish over SSH” -> 配置 “SSH
Servers” ,准备部署的服务器地址“Remote Directory”
即拷贝到远程主机的目标目录

插件:

-  NodeJS Plugin
-  Publish Over SSH

配置：
------

1. jenkins 创建一个自由风格Project

2. 源码管理 配置页面往下拉 -> “源码管理” -> 选择“Git” -> 在“Repository
   URL” 填入“项目地址” -> 点击“Add” 加入用户名密码 -> “Branches to
   build” 选择分支

3. 构建触发器

勾选“Build when a change is pushed to GitLab. GitLab CI Service URL:
http://jenkins.xxx.cn/project/xxx”

勾选“Filter branches by name” 这个决定那个分支有提交时才触发构建

Include -> master

Exclude -> develop

1. 构建环境

勾选“Provide Node & npm bin/ folder to PATH” 默认就选中
NodeJS(这个只有用到才需要选，gitbook 需要用npm 安装)

2. 构建

点击“增加构建步骤” -> 选中 “Execute shell” -> “Command” 内容为“gitbook
build .”

3. 构建后操作

点击“增加构建后操作步骤” -> 选中“Send build artifacts over SSH” ->
“Name” 选中在准备步骤中配置的主机 -> “Sourve files” 填入“_book" ->
“Remove prefix” 填入“__book" -> “点击保存”

4. jenkins 配置完成

5. 为了实现当项目 master
   分支有提交时，jenkins自动触发构建操作，需要在gitlab 配置“Webhooks”

在gitlab 项目页面点击“Webhooks” ，把配置步骤的第三小步中出现的URL
地址填到本页面的“URL”，其它默认，点击“Add Webhooks” 完成配置

6. 现在提交一下代码到项目master , jenkins就会自动构建

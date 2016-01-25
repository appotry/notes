# vscode使用技巧

删除文件行尾多余空格

![VSCODE](http://oi480zo5x.bkt.clouddn.com/VSCODE.jpg)

## vscode 使用七牛图床插件

插件名称 qiniu-upload-image

### Install

方法一

Ctrl+p (Mac下为command + p) 输入命令：
ext install qiniu-upload-image

方法二

![vscode-qiniu1-2017221](http://oi480zo5x.bkt.clouddn.com/vscode-qiniu1-2017221.jpg)

选择,安装即可

### 设置

F1 -> 输入settings -> 选择Open User Settings (或者Mac直接使用快捷键command + ,)

如果是Workspace Settings,则会在当前目录创建一个隐藏目录,.vscode,目录下面创建一个settings.json,如果使用git托管的话,这个文件会一并存放到仓库,所以如果有如下密钥信息的时候,设置到User Settings更好.

```json
  // 七牛图片上传工具开关
  "qiniu.enable": true,
  // 一个有效的七牛 AccessKey 签名授权。 个人面板 -> 密钥管理
  "qiniu.access_key": "",
  // 一个有效的七牛 SecretKey 签名授权。
  "qiniu.secret_key": "",
  // 七牛图片上传空间。 对象存储 -> 空间
  "qiniu.bucket": "yangjinjie",
  // 七牛图片上传路径，参数化命名。例如:xxx.jpg-20170221
  "qiniu.remotePath": "${fileName}-${date}",
  // 七牛图床域名。 空间对应的测试域名,或者可以绑定个人域名,类似如下地址
  "qiniu.domain": "http://oi480zo5x.bkt.clouddn.com",
```
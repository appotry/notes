# 部署应用到Heroku

[Heroku Getting Start](https://devcenter.heroku.com/start)

1. 注册账号 [Heroku account](https://signup.heroku.com/signup/dc).
2. 本地安装python 3.6
3. 安装setuptools, pip
4. 安装virtualenv
5. postgres

## 安装heroku

安装之后,登录, 安装方法往下看

```shell
$ heroku login
Enter your Heroku credentials.
Email: python@example.com
Password:
...
```

### Mac

```shell
brew install heroku
```

## 查看日志

```shell
heroku logs --tail
```

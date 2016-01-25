# getpass

包含下面两个函数:

1. getpass.getpass()
2. getpass.getuser()

getpass.getpass(prompt[, stream]) - Prompt for a password, with echo turned off.

提示用户输入一段密码，参数 prompt 用于提示用户开始输入，默认为'Password: '。在 Unix 上，该提示符被写入到类文件对象流中。参数 stream 默认为控制终端 (/dev/tty) 或入过前者不可用时为 sys.stderr (该参数在 Windows 上无效)。

如果无回显输入不可用，getpass() 回退并向流 stream 中输出一个警告消息，从 sys.stdin 中读取并抛出异常 GetPassWarning。

适用于： Macintosh, Unix, Windows.

如果你在 IDLE 中调用getpass()，输入可能会在你启动 IDLE 的终端中而不是在 IDLE 窗口中完成

```python
>>> import getpass
>>> p = getpass.getpass("xxx: ")
xxx:
>>> print(p)
123
```

exception getpass.GetPassWarning

　　Python内置异常 UserWarning 的子类，当密码输入可能被回显时抛出。

getuser() - Get the user name from the environment or password database.

返回用户的登录名，适用于：Unix, Windows

该函数依次检测环境变量 LOGNAME、USER、LNAME 和 USERNAME，返回其中第一个非空的值。如果这些变量都没有被设置，支持 pwd 模块的系统会返回密码数据库中的登录名，否则抛出异常。
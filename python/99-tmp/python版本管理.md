# python版本管理

## 使用virtualenv管理多个开发环境

[Virtualenv](https://virtualenv.pypa.io/en/latest/)

### 安装

    sudo pip3 install virtualenv virtualenvwrapper

[其他安装方法](https://virtualenv.pypa.io/en/latest/installation/)

### 用法

#### 创建一个新的virtualenv

```shell
root@ubuntu-linux:~# mkvirtualenv y  # 因为已经指定了默认的Python版本，所以默认的是Python3
Using base prefix '/usr'
New python executable in /root/.virtualenvs/y/bin/python3
Also creating executable in /root/.virtualenvs/y/bin/python
Installing setuptools, pip, wheel...done.
virtualenvwrapper.user_scripts creating /root/.virtualenvs/y/bin/predeactivate
virtualenvwrapper.user_scripts creating /root/.virtualenvs/y/bin/postdeactivate
virtualenvwrapper.user_scripts creating /root/.virtualenvs/y/bin/preactivate
virtualenvwrapper.user_scripts creating /root/.virtualenvs/y/bin/postactivate
virtualenvwrapper.user_scripts creating /root/.virtualenvs/y/bin/get_env_details
(y) root@ubuntu-linux:~#
# 创建成功之后会自动进入virtualenv中
```

退出virtualenv

在任意目录执行deactivate就可以退出

```shell
(y) root@ubuntu-linux:~# deactivate
root@ubuntu-linux:~#
```

查看所有virtualenv

```shell
root@ubuntu-linux:~# workon
y
```

在工作环境之间切换

```shell
root@ubuntu-linux:~# workon y
(y) root@ubuntu-linux:~#
```

删除一个virtualenv

```shell
(y) root@ubuntu-linux:~# deactivate
root@ubuntu-linux:~# rmvirtualenv y
Removing y...
root@ubuntu-linux:~#
root@ubuntu-linux:~# workon
root@ubuntu-linux:~#
```

## pyevn,管理安装python多版本

[GitHub pyenv](https://github.com/pyenv/pyenv)

### Install

#### 通用

This tool installs `pyenv` and friends. It is inspired by [rbenv-installer](https://github.com/fesplugas/rbenv-installer).

两种方式安装 [pyenv](https://github.com/pyenv/pyenv). The PyPi support is not tested by many users yet, so the direct way is still recommended if you want to play it safe.

通过Github安装 (推荐)

**Install:**

```shell
$ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
# 执行之后会有提示,按照提示操作即可

WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by adding
# the following to ~/.bash_profile:

export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

#### Mac

1. Homebrew on Mac OS X

You can also install pyenv using the [Homebrew](https://brew.sh) package manager for Mac OS X.

```shell
brew update
# 升级使用upgrade
brew install pyenv
```

2. 将`pyenv init`添加到shell

    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

如果使用Zsh或者Ubuntu等用如下文件代替`~/.bash_profile`

**Zsh note**: Modify your `~/.zshenv` file instead of `~/.bash_profile`.

**Ubuntu and Fedora note**: Modify your `~/.bashrc` file instead of `~/.bash_profile`.

3. 重启shell或执行如下命令开始使用pyenv

exec $SHELL

4. Install Python versions into $(pyenv root)/versions.

```shell
# 安装2.7.10
pyenv install 2.7.10
```

### 升级

```shell
pyenv update
```

### 卸载

`pyenv` is installed within `$PYENV_ROOT` (default: `~/.pyenv`). 卸载只需要移除该目录:

```shell
rm -fr ~/.pyenv
# 或者
rm -rf $(pyenv root)
# 如果使用brew安装的, 可以使用如下命令卸载
brew uninstall pyenv
```

从 `.bashrc`或其他相关文件, 移除环境变量,及pyenv初始化的命令:

```shell
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

### 使用

帮助信息

```shell
➜  ~ pyenv help
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   commands    List all available pyenv commands
   local       Set or show the local application-specific Python version
   global      Set or show the global Python version
   shell       Set or show the shell-specific Python version
   install     Install a Python version using python-build
   uninstall   Uninstall a specific Python version
   rehash      Rehash pyenv shims (run this after installing executables)
   version     Show the current Python version and its origin
   versions    List all Python versions available to pyenv
   which       Display the full path to an executable
   whence      List all Python versions that contain the given executable

See `pyenv help <command>' for information on a specific command.
For full documentation, see: https://github.com/pyenv/pyenv#readme
```

设置python版本

`pyenv shell`

```shell
➜  ~ pyenv help shell
Usage: pyenv shell <version>...
       pyenv shell -
       pyenv shell --unset
```

安装python版本

```shell
pyenv install 2.7.10
```

删除管理中的python版本

```shell
➜  versions git:(master) ls
2.7.10
➜  versions git:(master) pwd
~/.pyenv/versions
```

## pyenv-virtualenv

[GitHub pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

`pyenv-virtualenv`是一个`pyenv`插件, 在类Unix系统上管理Python `virtualenvs`和`conda`环境.

### 安装

通用

    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

Mac 系统

    brew install pyenv-virtualenv

### 配置

添加`echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile`到`.bashrc`或其他类似此文件功能的文件中.

```shell
➜  ~ tail -5 .zshrc

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

### 使用

创建虚拟环境

```shell
➜  ~ pyenv virtualenv 3.6.1 my-virtual-env-3.6.1 # 指定Python版本生成虚拟环境
➜  ~ pyenv version # 查看当前版本
system (set by /Users/boxfish/.pyenv/version)
➜  ~ pyenv virtualenv venv_system # 使用当前版本生成虚拟环境
```

**切换到venv_system虚拟环境**

```shell
➜  ~ pyenv shell venv_system
(venv_system) ➜  ~
```

**退出虚拟环境**

```shell
(venv_system) ➜  ~ pyenv shell --unset
➜  ~
```

查看所有虚拟环境

```shell
➜  ~ pyenv virtualenvs
  3.6.1/envs/my-virtual-env-3.6.1 (created from /Users/boxfish/.pyenv/versions/3.6.1)
  3.6.1/envs/ven36 (created from /Users/boxfish/.pyenv/versions/3.6.1)
  my-virtual-env-3.6.1 (created from /Users/boxfish/.pyenv/versions/3.6.1)
  ven36 (created from /Users/boxfish/.pyenv/versions/3.6.1)
  venv_system (created from /Library/Frameworks/Python.framework/Versions/3.5)
```

激活,退出虚拟环境

```shell
➜  ~ pyenv activate venv_system
pyenv-virtualenv: prompt changing will be removed from future release. configure `export PYENV_VIRTUALENV_DISABLE_PROMPT=1' to simulate the behavior.
```

```shell
(venv_system) ➜  ~ pyenv deactivate
➜  ~
```

删除

    pyenv uninstall my-virtual-env-3.6.1

### virtualenv and venv

There is a venv module available for CPython 3.3 and newer. It provides an executable module venv which is the successor of virtualenv and distributed by default.

pyenv-virtualenv uses python -m venv if it is available and the virtualenv command is not available.

## pyenv-virtualenvwrapper

[GitHub pyenv-virtualenvwrapper](https://github.com/pyenv/pyenv-virtualenvwrapper)

## 错误记录

### ERROR: The Python zlib extension was not compiled. Missing the zlib?

在Mac上安装了Parallels Desktop，然后安装了ubuntu16虚拟机，虚拟机中在用pyenv安装不同版本python的时候，最后失败，提示如下（部分）：

```shell
WARNING: The Python readline extension was not compiled. Missing the GNU readline lib?
ERROR: The Python zlib extension was not compiled. Missing the zlib?
```

如何解决

**ubuntu**

```shell
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev
```

**mac**

```shell
brew install readline xz
```

NOTE: libssl-dev is required when compiling Python, installing libssl-dev will actually install zlib1g-dev, which leads to uninstall and re-install Python versions (installed before installing libssl-dev). On Redhat and derivatives the package is named openssl-devel.
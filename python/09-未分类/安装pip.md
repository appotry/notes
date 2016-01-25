# pip

[pip](https://pip.pypa.io/en/latest/)

## 安装pip

下载 `get-pip.py`

    wget https://bootstrap.pypa.io/get-pip.py

运行命令

    python get-pip.py
    python3 get-pip.py # 没有python命令,有其他版本的话使用该版本运行

```shell
root@ubuntu-linux:~/src# pip -V
pip 9.0.1 from /usr/local/lib/python3.5/dist-packages (python 3.5)
```

## 升级

Linux or macOS:

    pip install -U pip

Windows:

    python -m pip install -U pip

## pip使用过程中遇到的问题

### MacOS OSError: [Errno 1] Operation not permitted

原因是Mac的内核保护,默认会锁定/system,/sbin,/usr目录

解决(不一定有用,没用可以关掉保护,百度...)

```shell
pip install --upgrade pip

sudo pip install numpy --upgrade --ignore-installed
sudo pip install scipy --upgrade --ignore-installed
sudo pip install scikit-learn --upgrade --ignore-installed
```
# Ubuntu使用zsh

## 安装zsh

```shell
apt-get install zsh
```

安装完后，需要将`zsh`替换为你的默认`shell`, 输入下面命令修改默认终端

```sehll
chsh -s /bin/zsh
```

重新打开终端即可

## 安装oh-my-zsh

[官网](http://ohmyz.sh/)

[GitHub地址](https://github.com/robbyrussell/oh-my-zsh)

详细信息可以查看GitHub

### 通过curl安装

```shell
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 通过wget安装

```shell
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

## 报错

### chsh: PAM: Authentication failure

    sudo vim /etc/pam.d/chsh

将 `auth required pam_shells.so` 注释，再次执行 `sudo chsh -s which zsh` 即可

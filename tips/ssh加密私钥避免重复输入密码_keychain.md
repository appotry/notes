# ssh加密私钥避免重复输入(keychain)

[ssh](https://wiki.archlinux.org/index.php/SSH_keys)

    中英文内容不太一样

[Keychain](http://www.funtoo.org/Keychain)

## keychain

开机的时候缓存私钥，只需要将如下命令写入到.bash_profile等位置

```shell
eval `keychain --eval --agents ssh 123.rsa` &>/dev/null
# 123.rsa为私钥名字，放在.ssh目录下，且需要公钥存在，123.rsa.pub
```

在第一次使用的时候缓存

```shell
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_ecdsa) && ssh'
```

### Mac电脑使用keychain

1. 安装brew

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

2. 使用brew安装 keychain

    brew install keychain

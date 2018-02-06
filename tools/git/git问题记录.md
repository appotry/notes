<!-- TOC -->

- [1. Git问题记录](#1-git%E9%97%AE%E9%A2%98%E8%AE%B0%E5%BD%95)
    - [1.1. Git Fatal: cannot do a partial commit during a merge](#11-git-fatal-cannot-do-a-partial-commit-during-a-merge)
    - [1.2. LF will be replaced by CRLF](#12-lf-will-be-replaced-by-crlf)
    - [1.3. 刚创建的github版本库，在push代码时出错](#13-%E5%88%9A%E5%88%9B%E5%BB%BA%E7%9A%84github%E7%89%88%E6%9C%AC%E5%BA%93%EF%BC%8C%E5%9C%A8push%E4%BB%A3%E7%A0%81%E6%97%B6%E5%87%BA%E9%94%99)
    - [1.4. git merge报错，fatal: refusing to merge unrelated histories](#14-git-merge%E6%8A%A5%E9%94%99%EF%BC%8Cfatal-refusing-to-merge-unrelated-histories)
    - [1.5. git pull提示“no tracking information”](#15-git-pull%E6%8F%90%E7%A4%BA%E2%80%9Cno-tracking-information%E2%80%9D)
    - [1.6. Access denied. fatal: Could not read from remote repository.  Please make sure you have the correct access rights and the repository exists.](#16-access-denied-fatal-could-not-read-from-remote-repository-please-make-sure-you-have-the-correct-access-rights-and-the-repository-exists)
    - [1.7. Mac升级系统之后,使用git的时候,报如下错误](#17-mac%E5%8D%87%E7%BA%A7%E7%B3%BB%E7%BB%9F%E4%B9%8B%E5%90%8E%E4%BD%BF%E7%94%A8git%E7%9A%84%E6%97%B6%E5%80%99%E6%8A%A5%E5%A6%82%E4%B8%8B%E9%94%99%E8%AF%AF)
    - [1.8. git status 中文显示乱码](#18-git-status-%E4%B8%AD%E6%96%87%E6%98%BE%E7%A4%BA%E4%B9%B1%E7%A0%81)
    - [1.9. 配置多个ssh-key](#19-%E9%85%8D%E7%BD%AE%E5%A4%9A%E4%B8%AAssh-key)

<!-- /TOC -->

# 1. Git问题记录

## 1.1. Git Fatal: cannot do a partial commit during a merge

在提交单个文件的时候出现这个错误.

意思是不能部分提交代码.

原因是Git认为你有部分代码没有做好提交的准备,比如没有添加

解决方法是

1. 提交全部

    git commit -a -m "xxx"

2. 如果不想提交全部,那么可以通过添加 -i 选项

    git commit file/to/path -i -m "merge"

上述情况一般出现在解决本地working copy冲突时出现, 本地文件修改(手工merge)完成后,要添加并提交,使得本地版本处于clean的状态.

这样以后git pull就不再会报错.

## 1.2. LF will be replaced by CRLF

```shell
warning: LF will be replaced by CRLF in readme.txt.
The file will have its original line endings in your working directory.

git config core.autocrlf false
```

## 1.3. 刚创建的github版本库，在push代码时出错

```shell
$ git push -u origin master
To git@github.com:**/Demo.git
! [rejected] master -> master (non-fast-forward)
error: failed to push some refs to ‘git@github.com:**/Demo.git’
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. ‘git pull’)
hint: before pushing again.
hint: See the ‘Note about fast-forwards’ in ‘git push –help’ for details.
```

> 网上搜索了下，是因为远程repository和我本地的repository冲突导致的，而我在创建版本库后，在github的版本库页面点击了创建README.md文件的按钮创建了说明文档，但是却没有pull到本地。这样就产生了版本冲突的问题。

有如下几种解决方法：

1. 使用强制push的方法：

```shell
git push -u origin master -f
# 这样会使远程修改丢失，一般是不可取的，尤其是多人协作开发的时候。
```

2. push前先将远程repository修改pull下来

```shell
git pull origin master
git push -u origin master
```

3. 若不想merge远程和本地修改，可以先创建新的分支

```sh
git branch [name]
# 然后push
git push -u origin [name]
```

## 1.4. git merge报错，fatal: refusing to merge unrelated histories

```shell
"git merge" used to allow merging two branches that have no common base by default, which led to a brand new history of an existing project created and then get pulled by an unsuspecting maintainer, which allowed an unnecessary parallel history merged into the existing project. The command has been taught not to allow this by default, with an escape hatch "--allow-unrelated-histories" option to be used in a rare event that merges histories of two projects that started their lives independently.
See the git release changelog for more information.

You can use --allow-unrelated-histories to force the merge to happen.

git merge --allow-unrelated-histories test
```

## 1.5. git pull提示“no tracking information”

原因: y本地分支和远程分支的链接关系没有创建，使用如下命令解决

    git branch --set-upstream branch-name origin/branch-name

或者:

    git branch --set-upstream-to=origin/dev dev

因此，多人协作的工作模式通常是这样：

* 首先，可以试图用git push origin branch-name推送自己的修改；
* 如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；
* 如果合并有冲突，则解决冲突，并在本地提交；
* 没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！

## 1.6. Access denied. fatal: Could not read from remote repository.  Please make sure you have the correct access rights and the repository exists.

个人ssh-key是在,修改资料里面添加,设置的公钥,拥有所有权限

项目部署key是在项目设置中设置的，是用于部署用，只能clone与pull

## 1.7. Mac升级系统之后,使用git的时候,报如下错误

xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun

解决办法,执行如下命令:

    xcode-select --install

## 1.8. git status 中文显示乱码

```shell
git config --global core.quotepath false
```

## 1.9. 配置多个ssh-key

直接指定

```shell
# github ysara
# 将 .git/config 下url github.com, 修改成别名 github_ysara
# 比如 原地址是：git@github.com:username/haha.git，替换后应该是：github_ysara:username/haha.git.
Host github_ysara
    HostName github.com
    User xxx@qq.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/ysara

# github yangjinjie
Host github.com
User xx@qq.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa
```

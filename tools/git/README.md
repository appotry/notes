<!-- TOC -->

- [1. 分布式版本控制](#1-分布式版本控制)
- [2. Git](#2-git)
    - [2.1. 常用命令速查表](#21-常用命令速查表)
    - [2.2. 新建代码库](#22-新建代码库)
    - [2.3. 配置](#23-配置)
    - [2.4. 增加/删除文件](#24-增加删除文件)
    - [2.5. 代码提交](#25-代码提交)
    - [2.6. 分支](#26-分支)
    - [2.7. 标签](#27-标签)
    - [2.8. 查看信息](#28-查看信息)
    - [2.9. 远程同步](#29-远程同步)
    - [2.10. 撤销](#210-撤销)
    - [2.11. 其他](#211-其他)
    - [2.12. 忽略特殊文件.gitignore](#212-忽略特殊文件gitignore)
    - [2.13. 小结](#213-小结)
- [3. 部分实例](#3-部分实例)
    - [3.1. 获取远程分支到本地](#31-获取远程分支到本地)
    - [3.2. 忽略特殊文件.gitignore](#32-忽略特殊文件gitignore)
    - [3.3. 删除错误提交](#33-删除错误提交)
    - [3.4. 全局忽略 .DS_Store](#34-全局忽略-ds_store)

<!-- /TOC -->

# 1. 分布式版本控制

分布式版本控制的每个节点都是完整仓库

> svn集中式版本控制

svn中央仓库挂了, 无法根据本地项目重新搭建一个服务器, 因为本地没有历史版本

# 2. Git

    Workspace：工作区
    Index / Stage：暂存区
    Repository：仓库区（或本地仓库）
    Remote：远程仓库

## 2.1. 常用命令速查表

![git-command](http://oi480zo5x.bkt.clouddn.com/git-command.png)

## 2.2. 新建代码库

在当前目录新建一个Git代码库

    git init

新建一个目录, 将其初始化为Git代码库

    git init [project-name]

下载一个项目和它的整个代码历史

    git clone [url]

## 2.3. 配置

Git的设置文件为.gitconfig, 它可以在用户主目录下（全局配置）, 也可以在项目目录下（项目配置）。

**显示当前的Git配置**

    git config --list

编辑Git配置文件

    git config -e [--global]

设置提交代码时的用户信息

    git config [--global] user.name "[name]"
    git config [--global] user.email "[email address]"

## 2.4. 增加/删除文件

    # 添加指定文件到暂存区
    $ git add [file1] [file2] ...
    # 添加指定目录到暂存区, 包括子目录
    $ git add [dir]
    # 添加当前目录的所有文件到暂存区
    $ git add .
    # 删除工作区文件, 并且将这次删除放入暂存区
    $ git rm [file1] [file2] ...
    # 停止追踪指定文件, 但该文件会保留在工作区
    $ git rm --cached [file]
    # 改名文件, 并且将这个改名放入暂存区
    $ git mv [file-original] [file-renamed]

## 2.5. 代码提交

    # 提交暂存区到仓库区, -m后面输入的是本次提交的说明, 可以输入任意内容, 当然最好是有意义的, 这样你就能从历史记录里方便地找到改动记录
    $ git commit -m [message]
    # 提交暂存区的指定文件到仓库区
    $ git commit [file1] [file2] ... -m [message]
    # 提交工作区自上次commit之后的变化, 直接到仓库区
    $ git commit -a
    # 提交时显示所有diff信息
    $ git commit -v
    # 使用一次新的commit, 替代上一次提交
    # 如果代码没有任何新变化, 则用来改写上一次commit的提交信息
    $ git commit --amend -m [message]
    # 重做上一次commit, 并包括指定文件的新变化
    $ git commit --amend [file1] [file2] ...

## 2.6. 分支

列出所有本地分支

    git branch

列出所有远程分支

    git branch -r

列出所有本地分支和远程分支

    git branch -a

新建一个分支, 但依然停留在当前分支

    git branch [branch-name]

**新建一个分支, 并切换到该分支**

    git checkout -b [branch]

新建一个分支, 指向指定commit

    git branch [branch] [commit]

新建一个分支, 与指定的远程分支建立追踪关系

    git branch --track [branch] [remote-branch]

切换到指定分支, 并更新工作区

    git checkout [branch-name]

建立追踪关系, 在现有分支与指定的远程分支之间

    git branch --set-upstream [branch] [remote-branch]

合并指定分支到当前分支

    git merge [branch]

选择一个commit, 合并进当前分支

    git cherry-pick [commit]

删除分支

    git branch -d [branch-name]

删除远程分支

    git push origin --delete [branch-name]
    git branch -dr [remote/branch]

## 2.7. 标签

列出所有tag

    git tag

新建一个tag在当前commit

    git tag [tag]

新建一个tag在指定commit

    git tag [tag] [commit]

查看tag信息

    git show [tag]

提交指定tag

    git push [remote] [tag]

提交所有tag

    git push [remote] --tags

新建一个分支, 指向某个tag

    git checkout -b [branch] [tag]

## 2.8. 查看信息

显示有变更的文件

    git status

显示当前分支的版本历史

    git log
    git log --pretty=oneline

显示commit历史, 以及每次commit发生变更的文件

    git log --stat

显示某个文件的版本历史, 包括文件改名

    git log --follow [file]

    git whatchanged [file]

显示指定文件相关的每一次diff

    git log -p [file]

显示指定文件是什么人在什么时间修改过

    git blame [file]

显示暂存区和工作区的差异

    git diff

显示暂存区和上一个commit的差异

    git diff --cached [file]

显示工作区与当前分支最新commit之间的差异

    git diff HEAD

显示两次提交之间的差异

    git diff [first-branch]...[second-branch]

显示某次提交的元数据和内容变化

    git show [commit]

显示某次提交发生变化的文件

    git show --name-only [commit]

显示某次提交时, 某个文件的内容

    git show [commit]:[filename]

**显示当前分支的最近几次提交**

    git reflog

## 2.9. 远程同步

    # 下载远程仓库的所有变动
    $ git fetch [remote]

    # 显示所有远程仓库
    $ git remote -v

    # 显示某个远程仓库的信息
    $ git remote show [remote]

    # 增加一个新的远程仓库, 并命名
    $ git remote add [shortname] [url]

    # 取回远程仓库的变化, 并与本地分支合并
    $ git pull [remote] [branch]

    # 上传本地指定分支到远程仓库
    $ git push [remote] [branch]

    # 强行推送当前分支到远程仓库, 即使有冲突
    $ git push [remote] --force

    # 推送所有分支到远程仓库
    $ git push [remote] --all

## 2.10. 撤销

    # 恢复暂存区的指定文件到工作区
    $ git checkout [file]

    # 恢复某个commit的指定文件到工作区
    $ git checkout [commit] [file]

    # 恢复上一个commit的所有文件到工作区
    $ git checkout .

    # 重置暂存区的指定文件, 与上一次commit保持一致, 但工作区不变
    $ git reset [file]

重置暂存区与工作区, 与上一次commit保持一致

    git reset --hard

**回退到上一个版本**

    git reset --hard HEAD^
    上上一个版本就是HEAD^^, 当然往上100个版本写100个^比较容易数不过来, 所以写成HEAD~100

重置当前分支的指针为指定commit, 同时重置暂存区, 但工作区不变

    git reset [commit]

重置当前分支的HEAD为指定commit, 同时重置暂存区和工作区, 与指定commit一致

    git reset --hard [commit]

重置当前HEAD为指定commit, 但保持暂存区和工作区不变

    git reset --keep [commit]

    # 新建一个commit, 用来撤销指定commit

后者的所有变化都将被前者抵消, 并且应用到当前分支

    git revert [commit]

## 2.11. 其他

```shell
    # 生成一个可供发布的压缩包
    $ git archive

    git add readme.txt

    $ git commit -m "wrote a readme file"
    [master (root-commit) cf4b2e8] wrote a readme file
    1 file changed, 1 insertion(+)
    create mode 100644 readme.txt
```

>简单解释一下git commit命令

```shell
    git commit命令执行成功后会告诉你, 1个文件被改动（我们新添加的readme.txt文件）, 插入了两行内容（readme.txt有两行内容）。
    为什么Git添加文件需要add, commit一共两步呢？因为commit可以一次提交很多文件, 所以你可以多次add不同的文件, 比如：
    $ git add file1.txt
    $ git add file2.txt file3.txt
    $ git commit -m "add 3 files."
```

## 2.12. 忽略特殊文件.gitignore

[生成.gitignore文件内容](https://www.gitignore.io/)

有些时候, 你必须把某些文件放到Git工作目录中, 但又不能提交它们, 比如保存了数据库密码的配置文件啦, 等等, 每次git status都会显示Untracked files ..., 有强迫症的童鞋心里肯定不爽。

解决办法: 在Git工作区的根目录下创建一个特殊的.gitignore文件, 然后把要忽略的文件名填进去, Git就会自动忽略这些文件。

不需要从头写.gitignore文件, GitHub已经为我们准备了各种配置文件, 只需要组合一下就可以使用了。所有配置文件可以直接在线浏览：[https://github.com/github/gitignore](https://github.com/github/gitignore)

忽略文件的原则是：

1. 忽略操作系统自动生成的文件, 比如缩略图等;
2. 忽略编译生成的中间文件、可执行文件等, 也就是如果一个文件是通过另一个文件自动生成的, 那自动生成的文件就没必要放进版本库, 比如Java编译产生的.class文件;
3. 忽略你自己的带有敏感信息的配置文件, 比如存放口令的配置文件。

编写.gitignore之后,将文件也提交到git,就完成了

有些时候, 你想添加一个文件到Git, 但发现添加不了, 原因是这个文件被.gitignore忽略了

```shell
$ git add App.class
The following paths are ignored by one of your .gitignore files:
App.class
Use -f if you really want to add them.
```

如果你确实想添加该文件, 可以用-f强制添加到Git：

    git add -f App.class

或者你发现, 可能是.gitignore写得有问题, 需要找出来到底哪个规则写错了, 可以用git check-ignore命令检查：

    git check-ignore -v App.class
    .gitignore:3:*.class    App.class

Git会告诉我们, .gitignore的第3行规则忽略了该文件, 于是我们就可以知道应该修订哪个规则。

## 2.13. 小结

* 初始化一个Git仓库, 使用git init命令。
* 添加文件到Git仓库, 分两步：
    * 第一步, 使用命令 `git add <file>`, 注意, 可反复多次使用, 添加多个文件;
    * 第二步, 使用命令 `git commit` , 完成

* 忽略某些文件时, 需要编写.gitignore;
* .gitignore文件本身要放到版本库里, 并且可以对.gitignore做版本管理！

# 3. 部分实例

## 3.1. 获取远程分支到本地

```shell
git fetch   # 将远程分支信息获取到本地, 再运行
git checkout -b local-branchname origin/remote_branchname  # 将远程分支映射到本地命名为local-branchname的分支。
git pull    # 拉取分支
```

## 3.2. 忽略特殊文件.gitignore

[生成.gitignore文件内容](https://www.gitignore.io/)

## 3.3. 删除错误提交

```shell
# 彻底回退到某个版本
git reset --hard <commit_id>
# 强制推送
git push origin HEAD --force
```

## 3.4. 全局忽略 .DS_Store

1. 创建 `~/.gitignore_global` 文件
2. 把需要全局忽略的文件类型写到这个文件里。

```shell
# .gitignore_global
### macOS ###
*.DS_Store
.AppleDouble
.LSOverride
```

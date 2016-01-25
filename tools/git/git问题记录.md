<!-- TOC -->

- [1. Git问题记录](#1-git问题记录)
    - [1.1. Git Fatal: cannot do a partial commit during a merge](#11-git-fatal-cannot-do-a-partial-commit-during-a-merge)
    - [1.2. LF will be replaced by CRLF](#12-lf-will-be-replaced-by-crlf)
    - [1.3. 刚创建的github版本库，在push代码时出错](#13-刚创建的github版本库在push代码时出错)
    - [1.4. git merge报错，fatal: refusing to merge unrelated histories](#14-git-merge报错fatal-refusing-to-merge-unrelated-histories)
    - [1.5. git pull提示“no tracking information”](#15-git-pull提示no-tracking-information)
    - [1.6. Access denied. fatal: Could not read from remote repository.  Please make sure you have the correct access rights and the repository exists.](#16-access-denied-fatal-could-not-read-from-remote-repository--please-make-sure-you-have-the-correct-access-rights-and-the-repository-exists)
    - [1.7. Mac升级系统之后,使用git的时候,报如下错误](#17-mac升级系统之后使用git的时候报如下错误)
    - [1.8. git status 中文显示乱码](#18-git-status-中文显示乱码)

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
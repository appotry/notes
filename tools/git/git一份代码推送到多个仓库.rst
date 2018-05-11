git 将代码推送到多个仓库
========================

命令方式添加远程仓库

::

    git remote set-url --add origin git@git.coding.net:ruiruiliu/notes.git

修改项目.git文件下的config文件（\ **提交到两个仓库的相同分支**\ ）
------------------------------------------------------------------

.. code:: shell

    [core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
        hideDotFiles = dotGitOnly
    [remote "origin"]
        url = ssh://gradle仓库地址
        url = http://gitlab仓库地址
        fetch = +refs/heads/*:refs/remotes/origin/*
    [branch "master"]
        remote = origin
        merge = refs/heads/master

修改项目.git文件下的config文件（\ **提交到两个仓库的不同分支**\ ）
------------------------------------------------------------------

.. code:: shell

    [core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
        hideDotFiles = dotGitOnly
    [remote "gradle"]
        url = ssh://gradle仓库地址
        fetch = +refs/heads/*:refs/remotes/gradle/*
    [remote "gitlab"]
        url = http://gitlab仓库地址
        fetch = +refs/heads/*:refs/remotes/gitlab/*
    [branch "master"]
        remote = origin
        merge = refs/heads/master
    [alias]
        publish=!sh -c \"git push gradle master && git push gitlab master:master\"

示例
----

.. code:: shell

    [core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
    [remote "origin"]
        url = git@git.coding.net:ruiruiliu/notes.git
    #    url = git@git.oschina.net:yangjinjie/notes.git
        fetch = +refs/heads/*:refs/remotes/origin/*
    #    pushurl = git@git.coding.net:ruiruiliu/notes.git   # 指定push代码到指定仓库
        url = git@git.oschina.net:yangjinjie/notes.git
    [branch "master"]
        remote = origin
        merge = refs/heads/master
    [user]
        name = yangjinjie
        email = 51474159@qq.com

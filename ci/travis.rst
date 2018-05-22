travis
======

`Getting started <https://docs.travis-ci.com/user/getting-started/>`__

Personal access tokens
----------------------

新建一个token,配置如下权限即可(token只显示一次)

.. figure:: http://oi480zo5x.bkt.clouddn.com/github-travis-token-setting.png
   :alt: github-travis-token-setting

   github-travis-token-setting

安装 Travis CI 命令行工具
-------------------------

.. code:: shell

    # 如果提示没有权限则使用 sudo
    sudo gem install travis

加密
----

.. code:: shell

    ➜  ~ travis encrypt -r LyonYang/blogs  GH_TOKEN=7a7c6ff62d0061.....

.. code:: shell

    ➜  blogs git:(master) cat .travis.yml
    env:
      global:
        - GH_REF: github.com/LyonYang/blogs.git
        - secure: "19/hXRSX06+LU0/O9JmvDOKOuZsKXv0yPvtgAQ1SJr0v0yqFUN7a5XqtkbHsqZIl+AQvT2tq9KHJAiuIpDoEPDc4tWxqz7JQlw1W4d74D38FFUsRVsPUGZCH+5F/jry7vndq04xoRVu3SC23asZudZ6kJExiQdFwtiVG+mC0hk3Ae8RXyjWqC8JjuQzOlyXeJir6yatIdaqYnZH6Mk7fXTmrx3EcOrTzZ+CsxrrPaR0t6Xy7mxprB9+20XE/hp94dcfXqyFkF9McWy5Xg4cbyy6jR67jGpZzCfiILm7jmRD/DCa/2iSlNvy5HNzr0Qt7ckgiugLMX7CytwdsX7B1S3adkSuoRjDglumyuz2oNFgVw4eqKJ4vMm4PfTl4gkrybFfh9roJozk02VBrX0tUaj/HUmYu5z0F5oSXoH4PWAmjUCL4o5NPp/CCEbAKJ4TXLD1d/uGcqV9vfyPghVIMwONfkPi3sxHI+TjSWHCVwDediQ38UKYnJEOvwMG1DbMpSr4nLnzt2gz1DasSNi32FMHkutoiF6RwbgJmN9VKjtOIlihvzIleVNYxv2DP9XgMdh2ks9fSYY2+SNv270C0U25Q8hwIJ5cpmkPKzobEtxTa8Cq47MHaVfCqaO4qvb4/9RX6O3yY84J8SaUdgnF2y+4nS+bZqwXV109g7Y4QXzo="
    #sudo: false
    script:
      - bash summary_create.sh
    after_script:
      - git config user.name "Lyon"
      - git config user.email "547903993@qq.com"
      - git status
      - git add SUMMARY.md
      - git commit -m "[Travis] Update SUMMARY.md"
      - git push -f "https://${GH_TOKEN}@${GH_REF}" HEAD:master

Travis CI仓库简单配置
---------------------

.. figure:: http://oi480zo5x.bkt.clouddn.com/travis-setting.jpg
   :alt: travis-setting

   travis-setting

Makefile
=================

设置环境变量
-------------------

示例::

    export FLASK_ENV=dev
    export FLASK_DEBUG=1

    dev:
        @echo $(FLASK_ENV)
        @echo $(FLASK_DEBUG)

不同target设置不同环境变量::

    dev:export FLASK_ENV=dev
    dev:export FLASK_DEBUG=1
    dev:
        @echo $(FLASK_ENV)
        @echo $(FLASK_DEBUG)

    prod:export FLASK_ENV=prod
    prod:export FLASK_DEBUG=0
    prod:
        @echo $(FLASK_ENV)
        @echo $(FLASK_DEBUG)


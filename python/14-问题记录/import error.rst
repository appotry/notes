ImportError
=====================

ImportError: cannot import name UnrewindableBodyError
----------------------------------------------------------------------

错误信息::

    File "/usr/lib/python2.7/site-packages/urllib3/util/__init__.py", line 4, in <module>
        from .request import make_headers
    File "/usr/lib/python2.7/site-packages/urllib3/util/request.py", line 5, in <module>
        from ..exceptions import UnrewindableBodyError
    ImportError: cannot import name UnrewindableBodyError

解决办法，重装 urllib3 库::

    pip uninstall urllib3
    pip install urllib3

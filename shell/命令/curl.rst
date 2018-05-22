curl
====

GET
---

.. code:: shell

    curl www.baidu.com

POST请求
--------

.. code:: shell

    curl -d "param1=value1&param2=value2" "http://www.baidu.com"

JSON格式的请求

.. code:: shell

    curl -l -H "Content-type: application/json" -X POST -d '{"phone":"13521389587","password":"test"}' http://domain/apis/users.json

应用
----

测速
~~~~

.. code:: shell

    curl -o /dev/null -s -w "%{http_code}\n%{http_connect}\n%{content_type}\n%{time_namelookup}\n%{time_redirect}\n%{time_pretransfer}\n%{time_connect}\n%{time_starttransfer}\n%{time_total}\n%{speed_download}\n" baidu.com

待整理
~~~~~~

http://www.cnblogs.com/gbyukg/p/3326825.html

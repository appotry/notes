Python练习
==========

生成激活码
----------

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    import uuid

    def generate_code(count):
        code_list = []
        for i in range(count):
            code = str(uuid.uuid4()).replace('-','').upper()
            if code not in code_list:
                code_list.append(code)

        return code_list

    if __name__ == '__main__':
        code_list = generate_code(200)
        for code in code_list:
            print(code)

闭包
----

.. code:: python

    s = [lambda x: x + i for i in range(10)]
    print(s[0](10))
    print(s[1](10))
    print(s[2](10))
    print(s[3](10))

.. code:: python

    def create_multipliers():
        multipliers = []

        for i in range(5):
            # 两种情况,结果与期望完全不一样
            # def multiplier(x):
            def multiplier(x, i=i):
                return i * x
            multipliers.append(multiplier)

        return multipliers
    for mu in create_multipliers():
        print(mu(2))

解决 两种方法

.. code:: python

    def create_multipliers():
        return [lambda x, i=i : i * x for i in range(5)]

.. code:: python

    from functools import partial
    from operator import mul

    def create_multipliers():
        return [partial(mul, i) for i in range(5)]

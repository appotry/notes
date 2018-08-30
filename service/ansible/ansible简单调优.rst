ansible简单调优
===================

关闭gathering facts
---------------------

不需要获取被控机器的 fact 数据，可以关闭fact功能。

只需要在 playbook 文件中加上 ``gather_facts: false`` 即可

.. code-block:: yaml

    - hosts: pre-saas-backend
      gather_facts:  false
      ......

开启pipelining
-------------------

为了兼容不同sudo配置，主要是 requiretty 选项。如果不使用sudo，建议开启。

修改配置文件 ``/etc/ansible/ansible.cfg``

使用长链接
---------------

前提：ssh版本高于5.6

.. code-block:: shell

  修改参数 /etc/ansible/ansible.cfg
  ssh_args = -C -o ControlMaster=auto -o ControlPersist=5d

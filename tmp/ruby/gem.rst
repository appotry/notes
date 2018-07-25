gem
===

.. code:: shell

    root@rabbit1:~# gem install rubygems-update
    root@rabbit1:~# update_rubygems
    gem install rubygems-update

使用RVM
-------

.. code:: shell

    root@ubuntu75:~/src/logstash-output/logstash-output-zabbix-3.0.0# \curl -sSL https://get.rvm.io | bash -s stable
    Downloading https://github.com/rvm/rvm/archive/1.28.0.tar.gz
    Downloading https://github.com/rvm/rvm/releases/download/1.28.0/1.28.0.tar.gz.asc
    Found PGP signature at: 'https://github.com/rvm/rvm/releases/download/1.28.0/1.28.0.tar.gz.asc',
    but no GPG software exists to validate it, skipping.
    Creating group 'rvm'

    Installing RVM to /usr/local/rvm/
    Installation of RVM in /usr/local/rvm/ is almost complete:

      * First you need to add all users that will be using rvm to 'rvm' group,
        and logout - login again, anyone using rvm will be operating with `umask u=rwx,g=rwx,o=rx`.

      * To start using RVM you need to run `source /etc/profile.d/rvm.sh`
        in all your open shell windows, in rare cases you need to reopen all shell windows.

    # Administrator,
    #
    #   Thank you for using RVM!
    #   We sincerely hope that RVM helps to make your life easier and more enjoyable!!!
    #
    # ~Wayne, Michal & team.

    In case of problems: https://rvm.io/help and https://twitter.com/rvm_io

    root@ubuntu75:~/src/logstash-output/logstash-output-zabbix-3.0.0# usermod -a -G rvm root
    root@ubuntu75:~/src/logstash-output/logstash-output-zabbix-3.0.0# id root
    uid=0(root) gid=0(root) groups=0(root),1000(rvm)
    root@ubuntu75:~/src/logstash-output/logstash-output-zabbix-3.0.0#


    rvm install jruby-9.1.6.0
    rvm use jruby-9.1.6.0


    https://github.com/jruby/jruby

    root@ubuntu75:~/src/jruby-9.1.6.0/bin# ll /usr/bin/ruby
    lrwxrwxrwx 1 root root 7 Mar 14  2016 /usr/bin/ruby -> ruby2.3*

    ruby -v

        ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]

    apt-get install ruby

    root@ubuntu75:/usr/share/logstash/bin# pwd
    /usr/share/logstash/bin
    root@ubuntu75:/usr/share/logstash/bin# ./logstash-plugin install logstash-output-zabbix

修改gem源
---------

.. code:: shell

    # 查看gem源
    root@ubuntu75:~# gem sources -l
    *** CURRENT SOURCES ***

    https://rubygems.org/

    # 移除
    root@ubuntu75:~# gem sources --remove https://rubygems.org/
    https://rubygems.org/ removed from sources

    # 添加
    root@ubuntu75:~# gem sources -a https://ruby.taobao.org
    https://ruby.taobao.org added to sources

    root@ubuntu75:~# gem sources -l
    *** CURRENT SOURCES ***

    https://ruby.taobao.org

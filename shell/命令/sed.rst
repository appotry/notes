sed
===

删除 md 中的 TOC

.. code:: shell


    grep -rn '<!-- TOC -->' .|awk -F ":" '{print "sed -i \047/<!-- TOC -->/,/<!-- \\/TOC -->/\047d \""$1"\""}'|bash

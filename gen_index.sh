#!/bin/bash

dir=`find . -type d |egrep -v "\.git|assets|_book|node_modules|\.vscode|^\.$"|sed 's#\./##g'|sed 's# #@#g'`

for path in $dir
do
  echo $path
  title=`basename "$path"|gsed "s#^[0-9].*-##g"|sed 's#@# #g'`
  echo $title
  index_file=`echo "${path}/index.rst" | sed 's#@#\\ #g'`
  echo $index_file
  echo -e "$title
==============================

.. toctree::
   :glob:

   */index
   *
" > "${index_file}"
done

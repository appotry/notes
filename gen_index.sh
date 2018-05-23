#!/bin/bash

# delete *.rst
# find . -type f -name "*.rst" ! -path "./index.rst" | xargs rm -f

# md2rst
# find . -type f -name "*.md"|awk -F "." '{print "pandoc -f markdown -t rst \""$0"\" -o \"." $2".rst\""}'|bash

# delete md
# find . -type f -name "*.md" |awk '{print "rm \""$0"\""}'|bash

# gen index
dir=`find . -type d |egrep -v "\.git|assets|_summary|_static|_build|_book|node_modules|\.vscode|^\.$"|sed 's#\./##g'|sed 's# #@#g'`

# echo $dir

for path in $dir
do
    # echo $path
    title=`basename "$path"|sed "s#^[0-9].*-##g"|sed 's#@# #g'`
    # echo $title
    index_file=`echo "${path}/index.rst" | sed 's#@#\\ #g'`
    # echo $index_file
    if [ -e "$index_file" ];then
        continue
    fi
  # echo $index_file
  echo -e "$title
==============================

.. toctree::
   :glob:

   */index
   *
" > "${index_file}"
done


# summary(){
    
# index_dir="./_summary"
# first_dir=`tree -Nd -L 1 -i |grep -v "^[_0-9\.]"`

# for d in $first_dir
# do
#     echo $d
#     title=$d
#     content=`find $d -type d|sort|awk '{print "    ../"$0"/*"}'`

#     index_file="${index_dir}/${d}.rst"
#     # echo > $index_file

#     echo -e "$title
# ==============================

# .. toctree::
#     :glob:

# $content"

# #> "${index_file}"

# done
# }
#!/bin/bash

# 工作目录为 用户名/仓库名
notes_dir="$PWD"
echo $notes_dir

build_deploy(){
    dir=$1
    if [ "${dir}" == "notes" ];then
        repository_name="${dir}"
    else
        repository_name="${dir}_notes"
        cd $dir
    fi

    gitbook install 2>/dev/null
    gitbook build .

    echo -e "\033[33m ----部署文件 ${repository_name} ---- \033[0m"
    cd _book/
    echo $PWD

    # gitbook@3.2.3
    # gitbook-cli@2.3.2
    # 修正 文件名带空格导致 SUMMARY 跳转有问题
    sed -i '/a href.*\.md/s#\.md#.html#g;/a href.*README\.html/s#README\.html##g' SUMMARY.html

    git init
    git remote add origin git@github.com:yangjinjie/${repository_name}.git
    git checkout -b gh-pages
    echo "..."
    git add .
    git status|tail -5
    git commit -m "update site: `date "+%F %H:%M:%S" --date="+8 hour"`"
    git push -f "https://${GH_TOKEN}@github.com/yangjinjie/${repository_name}.git" gh-pages:gh-pages
    cd $notes_dir
}

pre_build(){
    # gitbook@3.2.3
    # gitbook-cli@2.3.2
    # 当前版本, 生成html之后, book.json 不再存在
    for dir in java python
    do
        # create summary
        cp -fv summary_create.sh ${dir}
        cd ${dir} && bash summary_create.sh "8" && cd .. 

        cp -fv book.json ${dir}
        # editlink, 保证子目录项目, 编辑本页可用
        sed -i "s#notes/blob/master#notes/blob/master/${dir}#g" ${dir}/book.json

    done

    dir=$1
    if [ "$dir" != "notes" ];then
        echo $dir
    else
        mv assets /tmp
        bash summary_create.sh "8"
    fi
}

rst(){
    cd ..
    git clone https://github.com/yangjinjie/notes.git notes_rst
    cd notes_rst
    echo $PWD
    git checkout -b rst origin/rst
    git merge -m "[Travis] Merge branch 'master' into rst" master
    bash gen_index.sh && git add . && git commit -m "[Travis] gen index & md2rst"
    git push "https://${GH_TOKEN}@github.com/yangjinjie/notes.git" rst:rst

    cd $notes_dir
}

main(){
    date "+%F %H:%M:%S"
    git config --global user.name "yangjinjie"
    git config --global user.email "51474159@qq.com"
    git config --global core.quotepath false

    for dir in $@
    do
        if [ "$dir" == "rst" ];then
            rst
            continue
        fi
        pre_build $dir
        build_deploy $dir
    done
}

main $@
#!/bin/bash

# 工作目录为用户名
notes_dir="$PWD"

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

main(){
    date "+%F %H:%M:%S"
    git config --global user.name "yangjinjie"
    git config --global user.email "51474159@qq.com"
    git config --global core.quotepath false

    for dir in $@
    do
        pre_build $dir
        build_deploy $dir
    done
}

main $@
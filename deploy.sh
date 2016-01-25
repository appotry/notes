#!/bin/bash

# 工作目录为用户名
DEPLOY_DIR="`dirname $PWD`/deploy"
notes_dir="$PWD"

gitbook_branch(){
    bash summary_create.sh "8"
    git checkout -b gitbook
    git status
    git add .
    git commit -m "travis: Update SUMMARY.md"
    git push -f "https://${GH_TOKEN}@${GH_REF}" gitbook:gitbook
}

build_deploy(){
    dir=$1
    if [ "${dir}" == "notes" ];then
        repository_name="${dir}"
    else
        repository_name="${dir}_notes"
        cd $dir
    fi

    notes_dir=${DEPLOY_DIR}/${repository_name}

    git clone --depth=2 --branch=gh-pages https://github.com/yangjinjie/${repository_name}.git ${notes_dir}

    gitbook install 2>/dev/null
    gitbook build .

    echo -e "\033[33m ----删除仓库内HTML---- \033[0m"
    find ${notes_dir} -name "*.html"|sed 's#^#mv -fv \"#g'|sed 's#$#\" /tmp#g'|bash > /tmp/mv.log && tail /tmp/mv.log
    echo -e "\033[33m ----准备待部署文件---- \033[0m"
    cp -rfv _book/* ${notes_dir} | tail

    cd ${notes_dir}
    find . -name "*.md"|sed 's#^#mv -fv \"#g'|sed 's#$#\" /tmp#g'|bash > /tmp/mv.log && tail /tmp/mv.log
    git status|head
    echo "..."
    git status|tail
    git add .
    # git commit -m "Update Site: `date "+%F %H:%M:%S"`"
    git commit -m "Update Site: `date "+%F %H:%M:%S" --date="+8 hour"`"
    git push "https://${GH_TOKEN}@github.com/yangjinjie/${repository_name}.git" gh-pages:gh-pages
    cd $notes_dir
    if [ -d "$dir" ];then
        mv -v $dir /tmp
    fi
}

pre_build(){
    # notes不处理, 处理其他目录
    dir=$1
    if [ "$dir" != "notes" ];then
        # create summary
        cp -f summary_create.sh ${dir}
        cd ${dir} && bash summary_create.sh "8" && cd ..

        # book.json
        cp -f book.json ${dir}
        # editlink, 保证子目录项目, 编辑本页可用
        sed -i "s#notes/blob/master#notes/blob/master/${dir}#g" ${dir}/book.json
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
        if [ "$dir" = "gitbook" ];then
            gitbook_branch
            break
        fi
        pre_build $dir
        build_deploy $dir
    done
}

main $@
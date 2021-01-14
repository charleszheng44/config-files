#!/usr/bin/env bash

bookmark_file=$HOME/tmp/bookmark

# add_bookmark adds current dir to bookmarks
function add_bookmark {
    bookmark_name=$1

    # check duplicate
    while read -r line; do 
        bm=$(echo $line | awk '{print $1}')   
        bm_path=$(echo $line | awk '{print $2}')
        if [ "$bookmark_name" == "$bm" ]; then
            echo "$line exist"
            echo "can't store two bookmarks with same name"
            return
        fi
    done < ${bookmark_file}

    bookmark_dir=$(pwd)

    if [ ! -f ${bookmark_file} ]
    then 
        touch ${bookmark_file}
    fi

    echo -e "${bookmark_name}\t${bookmark_dir}" >> ${bookmark_file}
}

# del_bookmark deletes first met bookmark entry that has same 
# bookmark name as the first argument
function del_bookmark {
    # TODO only work for BSD sed (OSX or FreeBSD)
    sed -i '' "/$1	/d" ${bookmark_file}
}

# goto_bookmark cd to target directory
function goto_bookmark {
    trgt_bm=$1
    while read -r line; do 
        bm=$(echo $line | awk '{print $1}')   
        bm_path=$(echo $line | awk '{print $2}')
        if [ "$trgt_bm" == "$bm" ]; then
            cd ${bm_path}
            return 
        fi
    done < ${bookmark_file}

    echo "${trgt_bm} not exist"
    return
}

# list_bookmark lists all available bookmarks
function list_bookmark {
    if [ -f ${bookmark_file} ] 
    then
        echo "bookmarks:"
        cat ${bookmark_file}
    else 
        echo "bookmarks not exist"
        touch ${bookmark_file}
    fi 
}

alias lb='list_bookmark'
alias gb='goto_bookmark'
alias db='del_bookmark'
alias ab='add_bookmark'

#!/bin/bash
currentdir=`pwd`
remove_pattern="pattern_to_replace"
repo=${currentdir}/repos
branch="feature/removeRef"
for dir in `find ${repo} -maxdepth 1 -mindepth 1`
do
    cd ${dir}
    for file in `find . -type f -exec grep -I -q . {} \; -print|egrep -v ".metadata|.git|.project|.settings"|xargs egrep -i "${remove_pattern}"|grep -v gcloud|awk -F":" '{print $1}'`
    do    
        git checkout -b ${branch} || echo branch already there
        sed -i '' 's/oldpattern/newpattern/g' ${file}
        sed -i '' 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/127.0.0.1/g'  ${file}
    done
    git branch |grep ${branch} 
    if [ $? -eq 0 ]; then 
        git add . 
        git commit -m "update branch"
        git push --set-upstream origin ${branch}
    fi
done

cd ${currentdir}

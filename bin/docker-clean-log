#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ "$1" != "-y" ] ;then
    printf "Do you want to remove all log files (y/n)? " 
    read answer
else
    answer=y
fi

if [ "$answer" != "${answer#[Yy]}" ] ;then
  
    cd ${SCRIPT_DIR}
    cd ../docker/logs
    
#    find . -name \*.log -delete
    find . -not -name '.gitignore' -delete 
    
    echo Everything is gone!!!
else
    echo Goodbye!!!
fi

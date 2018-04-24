#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ "$1" != "-y" ] ;then
    printf "Just stopping. It's not removing containers. \nDo you want to stop docker now (y/n)? " 
    read answer
else
    answer=y
fi

if [ "$answer" != "${answer#[Yy]}" ] ;then
  
    cd ${SCRIPT_DIR}
    cd ..
    
    docker-compose stop
    docker-compose ps
    
    echo "Ok. Let's play a game!!!"
else
    echo "Ok. Let's continue working 24/7!!!"
fi

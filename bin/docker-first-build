#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ "$1" != "-y" ] ;then
    printf "Do you want to build new docker (y/n)? " 
    read answer
else
    answer=y
fi

if [ "$answer" != "${answer#[Yy]}" ] ;then

    cd ${SCRIPT_DIR}
    cd ..
    
    docker-compose build --no-cache
    docker-compose up -d
    docker-compose ps
    
else
    echo Goodbye!!!
fi

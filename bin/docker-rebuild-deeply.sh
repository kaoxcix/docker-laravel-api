#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

RED='\033[0;31m'
NC='\033[0m'

if [ "$1" != "-y" ] ;then
    printf "Do you want to ${RED}DEEPLY${NC} rebuild docker (y/n)? " 
    read answer
else
    answer=y
fi

if [ "$answer" != "${answer#[Yy]}" ] ;then

    cd ${SCRIPT_DIR}
    cd ..
    
    docker-compose down
    docker-compose build --no-cache
    docker-compose up -d
    docker-compose ps
    
else
    echo Goodbye!!!
fi

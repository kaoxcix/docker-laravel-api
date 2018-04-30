FROM php:alpine

RUN apk update \
    && apk add curl 

RUN curl -sL https://github.com/ptrofimov/beanstalk_console/archive/master.tar.gz | tar xvz -C /tmp
RUN mv /tmp/beanstalk_console-master /source

RUN rm -rf /var/cache/apk/*

EXPOSE 2080

CMD BEANSTALK_SERVERS=beanstalkd:11300 php -S 0.0.0.0:2080 -t /source/public

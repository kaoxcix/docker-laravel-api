FROM alpine

RUN apk update \
    && apk add beanstalkd \
    && rm -rf /var/cache/apk/*
   
#VOLUME /var/lib/beanstalkd/data  
 
EXPOSE 11300
CMD beanstalkd -p 11300

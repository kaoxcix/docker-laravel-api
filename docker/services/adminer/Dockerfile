# Ref from
# - https://github.com/TimWolla/docker-adminer/issues/15
FROM adminer:latest

USER root
RUN apk update && apk add --no-cache --virtual .php-ext-deps \
      unixodbc \ 
      freetds

RUN apk update && apk add --no-cache --virtual .build-deps \
      unixodbc-dev \
      freetds-dev

RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr 

RUN docker-php-ext-install \
           pdo_odbc pdo_dblib

RUN apk del .build-deps \
    && rm -rf /var/cache/apk/*

USER adminer

EXPOSE 8080


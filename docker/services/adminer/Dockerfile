### SQL SERVER ####################################################################
# Ref from:
# - https://github.com/laradock
# - https://github.com/laradock/php-fpm
# - https://github.com/Microsoft/msphpsql/wiki/Install-and-configuration
ARG VERSION=${VERSION}
FROM php:${VERSION}

ARG DEBIAN_FRONTEND=noninteractive

# - Add Microsoft repo for Microsoft ODBC Driver 13 for Linux
RUN apt-get update -yqq \
  && apt-get install -y apt-transport-https gnupg \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update -yqq \
  # - Install Dependencies
  && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && ln -s /etc/locale.alias /usr/share/locale/locale.alias \
  && locale-gen \
  # - Install pdo_sqlsrv and sqlsrv from PECL
  && pecl install sqlsrv \
  && pecl install pdo_sqlsrv \
  && docker-php-ext-enable pdo_sqlsrv sqlsrv

# Clean up
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www/html

CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]

EXPOSE 8080

### DB_LIB VERSION ########################################################################
# Ref from
# - https://github.com/TimWolla/docker-adminer/issues/15
#FROM adminer:latest
#
#USER root
#RUN apk update && apk add --no-cache --virtual .php-ext-deps \
#      unixodbc \ 
#      freetds
#
#RUN apk update && apk add --no-cache --virtual .build-deps \
#      unixodbc-dev \
#      freetds-dev
#
#RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr 
#
#RUN docker-php-ext-install \
#           pdo_odbc pdo_dblib
#
#RUN apk del .build-deps \
#    && rm -rf /var/cache/apk/*
#
#USER adminer
#
#EXPOSE 8080

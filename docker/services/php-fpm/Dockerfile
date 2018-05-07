# Ref from:
# - https://github.com/laradock
# - https://github.com/laradock/php-fpm
# - https://github.com/Microsoft/msphpsql/wiki/Install-and-configuration
ARG VERSION=${VERSION}
FROM php:${VERSION}-fpm
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yqq \
    && apt-get install -y \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        zip \
        apt-utils \
        curl \ 
        gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Gd
RUN docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

# Configure Zip
RUN apt-get update -yqq \
    && apt-get install -y cmake zlib1g-dev openssl libbz2-dev \
    && mkdir /tmp/libzip && cd /tmp/libzip && curl -sSLO https://libzip.org/download/libzip-1.5.1.tar.gz \
    && tar zxf libzip-1.5.1.tar.gz && cd libzip-1.5.1/ && mkdir build && cd build && cmake ../ \
    && make > /dev/null && make install \
    && docker-php-ext-configure zip --with-libzip=/usr/local/lib/libzip.so \
    && docker-php-ext-install zip

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install bcmath \
    opcache
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Install Image Optimizers
USER root
ARG INSTALL_IMAGE_OPTIMIZERS=false
RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y --force-yes jpegoptim optipng pngquant gifsicle \
;fi

# Install Imagemagick
USER root
ARG INSTALL_IMAGEMAGICK=false
RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y libmagickwand-dev imagemagick && \
    pecl install imagick && \
    docker-php-ext-enable imagick \
;fi

# Install INTL
ARG INSTALL_INTL=false
RUN if [ ${INSTALL_INTL} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi

# Install Sql Server Driver
# - Add Microsoft repo for Microsoft ODBC Driver 17 for Linux
RUN apt-get update -yqq \
    && apt-get install -y apt-transport-https \
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

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql mysqli

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql pgsql \
    # Install the pgsql client
    && mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/man/man7 \
    && apt-get update -yqq \
    && apt-get install -y postgresql-client

# Install Redis
RUN printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

# Custom configuration
COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/
COPY ./log.conf /usr/local/etc/php-fpm.d/

# Create log directory
USER root
RUN mkdir -p /var/log/php-fpm

# Clean up
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www/html

CMD ["php-fpm"]

EXPOSE 9000

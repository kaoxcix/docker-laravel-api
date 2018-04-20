# Ref from:
# - https://github.com/laradock
# - https://github.com/laradock/php-fpm
# - https://github.com/Microsoft/msphpsql/wiki/Install-and-configuration

FROM php:7.2-fpm

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        curl \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        libzip-dev \
        zip \
        apt-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Gd
RUN docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

# Configure Zip
RUN docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install bcmath \
    opcache \
    tokenizer \
    json

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Install Image Optimizers
USER root
ARG INSTALL_IMAGE_OPTIMIZERS=false
RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
    apt-get update -yqq && \
    apt-get install -yqq --force-yes jpegoptim optipng pngquant gifsicle \
;fi

# Install Imagemagick
USER root
ARG INSTALL_IMAGEMAGICK=false
RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
    apt-get update -yqq && \
    apt-get install -yqq libmagickwand-dev imagemagick && \
    pecl install imagick && \
    docker-php-ext-enable imagick \
;fi

# Install INTL
ARG INSTALL_INTL=false
RUN if [ ${INSTALL_INTL} = true ]; then \
    apt-get update -yqq && \
    apt-get install -yqq zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi

# Install Sql Server Driver
# - Add Microsoft repo for Microsoft ODBC Driver 13 for Linux
RUN apt-get update -yqq \
    && apt-get install -yqq apt-transport-https gnupg \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -yqq \
    # - Install Dependencies
    && ACCEPT_EULA=Y apt-get install -yqq unixodbc unixodbc-dev libgss3 odbcinst msodbcsql locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && ln -s /etc/locale.alias /usr/share/locale/locale.alias \
    && locale-gen \
    # - Install pdo_sqlsrv and sqlsrv from PECL. Replace pdo_sqlsrv-4.1.8preview with preferred version.
    && pecl install pdo_sqlsrv-4.1.8preview sqlsrv-4.1.8preview \
    && docker-php-ext-enable pdo_sqlsrv sqlsrv \
    && php -m | grep -q 'pdo_sqlsrv' \
    && php -m | grep -q 'sqlsrv'

# Custom NGINX configuration
#COPY ./laravel.ini /usr/local/etc/php/conf.d
#COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www/html

CMD ["php-fpm"]

EXPOSE 9000

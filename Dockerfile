FROM php:7.1-fpm-alpine

RUN apt-get update \
    && apt-get install -y zlib1g-dev libicu-dev g++ git php7-imagick \
    && docker-php-ext-configure intl \
    &&  docker-php-ext-install mbstring pdo_mysql mysql intl
    && cd /usr/bin \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && ln -s composer.phar composer

RUN echo '[Date]\ndate.timezone = "Europe/Paris"' > /usr/local/etc/php/conf.d/timezone.ini

RUN usermod -u 1000 www-data

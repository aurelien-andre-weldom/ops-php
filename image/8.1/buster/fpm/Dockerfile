#
# OPS PHP
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
# @see https://github.com/aurelien-andre-weldom/ops-php
#
FROM ops-debian/debian:buster-slim

ENV \
PHP_VERSION="8.1" \
PHP_SUITE="buster" \
PHP_VARIANT="fpm"

ENV \
FPM_PID="/var/pid/php8.1-fpm.pid" \
FPM_LISTENER="/var/run/php8.1-fpm.sock" \
FPM_INCLUDE="/etc/php/8.1/fpm/pool.d/*.conf" \
FPM_ERROR_LOG="/proc/self/fd/1" \
FPM_PM="ondemand" \
FPM_PM_MAX_CHILDREN="5" \
FPM_PM_START_SERVERS="2" \
FPM_PM_MIN_SPARE_SERVERS="1" \
FPM_PM_MAX_SPARE_SERVERS="3" \
FPM_PM_PROCESS_IDLE_TIMEOUT="10s" \
FPM_PM_MAX_REQUESTS="500"

USER root

RUN set -eux; \
apt-get update; \
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN set -eux; \
apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
php8.1-cli \
php8.1-fpm \
php8.1-common \
php8.1-bcmath \
php8.1-opcache \
php8.1-apcu \
php8.1-amqp \
php8.1-xdebug \
php8.1-redis \
php8.1-curl \
php8.1-soap \
php8.1-mbstring \
php8.1-mysql \
php8.1-xml \
php8.1-xsl \
php8.1-gd \
php8.1-intl \
php8.1-ftp \
php8.1-iconv \
php8.1-zip

RUN set -eux; \
ln -sf \
/etc/php/8.1/99-php.ini \
/etc/php/8.1/cli/conf.d/99-php.ini

RUN set -eux; \
ln -sf \
/etc/php/8.1/99-php.ini \
/etc/php/8.1/fpm/conf.d/99-php.ini; \
ln -sf \
/usr/sbin/php-fpm8.1 \
/usr/sbin/php-fpm

RUN set -eux; \
mkdir -p \
/etc/php \
/var/log\opcache \
/var/lock\opcache; \
chmod 777 -R \
/etc/php \
/var/log\opcache \
/var/lock\opcache; \
chown rootless:rootless \
/etc/php \
/var/log\opcache \
/var/lock\opcache

COPY --chown=rootless:rootless system .

RUN set -eux; \
chmod +x /usr/bin/docker-*; \
chmod +x /usr/bin/php*

RUN set -eux; \
echo "docker-entrypoint-php.sh" >> /docker-entrypoint.list

ENTRYPOINT ["docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT

EXPOSE 9001
EXPOSE 9000

CMD ["supervisord"]

USER rootless

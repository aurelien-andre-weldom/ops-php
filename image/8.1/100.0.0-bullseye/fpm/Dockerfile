#
# OPS PHP
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
# @see https://github.com/aurelien-andre-weldom/ops-php
#
FROM ops-debian/debian:100.0.0-bullseye

ENV \
VERSION="8.1" \
SUITE="100.0.0-bullseye" \
VARIANT="fpm" \
PHP_MEMORY_LIMIT="4G" \
PHP_REALPATH_CACHE_SIZE="4096K" \
PHP_REALPATH_CACHE_TTL="600" \
PHP_SENDMAIL_PATH="" \
PHP_XDEBUG__MODE="off" \
PHP_XDEBUG__CLIENT_PORT="9003" \
PHP_XDEBUG__CLIENT_HOST="172.17.0.1" \
PHP_XDEBUG__IDEKEY="PHPSTORM" \
PHP_OPCACHE__ENABLE="0" \
PHP_OPCACHE__ENABLE_CLI="0" \
PHP_OPCACHE__MEMORY_CONSUMPTION="256" \
PHP_OPCACHE__INTERNED_STRINGS_BUFFER="8" \
PHP_OPCACHE__MAX_ACCELERATED_FILES="60000" \
PHP_OPCACHE__MAX_WASTED_PERCENTAGE="5" \
PHP_OPCACHE__USE_CWD="1" \
PHP_OPCACHE__VALIDATE_TIMESTAMPS="0" \
PHP_OPCACHE__REVALIDATE_FREQ="2" \
PHP_OPCACHE__REVALIDATE_PATH="0" \
PHP_OPCACHE__SAVE_COMMENTS="1" \
PHP_OPCACHE__RECORDS_WARNING="0" \
PHP_OPCACHE__ENABLE_FILE_OVERRIDE="0" \
PHP_OPCACHE__OPTIMIZATION_LEVEL="0x7FFFBFFF" \
PHP_OPCACHE__DUPS_FIX="0" \
PHP_OPCACHE__BLACKLIST_FILENAME="/etc/php/8.1/opcache-*.blacklist" \
PHP_OPCACHE__MAX_FILE_SIZE="0" \
PHP_OPCACHE__CONSISTENCY_CHECKS="0" \
PHP_OPCACHE__FORCE_RESTART_TIMEOUT="180" \
PHP_OPCACHE__ERROR_LOG="/var/log/opcache" \
PHP_OPCACHE__LOG_VERBOSITY_LEVEL="1" \
PHP_OPCACHE__PREFERRED_MEMORY_MODEL="" \
PHP_OPCACHE__PROTECT_MEMORY="0" \
PHP_OPCACHE__RESTRICT_API="" \
PHP_OPCACHE__MMAP_BASE="" \
PHP_OPCACHE__CACHE_ID="" \
PHP_OPCACHE__FILE_CACHE="/var/cache/opcache" \
PHP_OPCACHE__FILE_CACHE_ONLY="0" \
PHP_OPCACHE__FILE_CACHE_CONSISTENCY_CHECKS="1" \
PHP_OPCACHE__FILE_CACHE_FALLBACK="1" \
PHP_OPCACHE__HUGE_CODE_PAGE="1" \
PHP_OPCACHE__VALIDATE_PERMISSION="0" \
PHP_OPCACHE__VALIDATE_ROOT="0" \
PHP_OPCACHE__OPT_DEBUG_LEVEL="0" \
PHP_OPCACHE__PRELOAD="" \
PHP_OPCACHE__PRELOAD_USER="rootless" \
PHP_OPCACHE__LOCKFILE_PATH="/var/lock/opcache" \
PHP_OPCACHE__JIT="1255" \
PHP_OPCACHE__JIT_BUFFER_SIZE="400MB"

ENV \
FPM_PID="/var/pid/php8.1-fpm.pid" \
FPM_ERROR_LOG="/proc/self/fd/1" \
FPM_LISTENER="/var/run/php8.1-fpm.sock" \
FPM_PM="ondemand" \
FPM_PM_MAX_CHILDREN="5" \
FPM_PM_START_SERVERS="2" \
FPM_PM_MIN_SPARE_SERVERS="1" \
FPM_PM_MAX_SPARE_SERVERS="3" \
FPM_PM_PROCESS_IDLE_TIMEOUT="10s;" \
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
/etc/php/8.1/90-php.ini \
/etc/php/8.1/cli/conf.d/90-php.ini

RUN set -eux; \
ln -sf \
/etc/php/8.1/90-php.ini \
/etc/php/8.1/fpm/conf.d/90-php.ini

RUN set -eux; \
mkdir -p \
/etc/php; \
chmod 777 -R \
/etc/php; \
chown rootless:rootless \
/etc/php

COPY --chown=rootless:rootless system .

RUN set -eux; \
chmod +x /usr/bin/docker-*; \
chmod +x /usr/bin/php*

RUN set -eux; \
echo "docker-entrypoint-php" >> /docker-entrypoint.list

ENTRYPOINT ["docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT

EXPOSE 9001
EXPOSE 9000

CMD ["supervisord"]

USER rootless

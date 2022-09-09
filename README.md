# OPS PHP

Create your php templates in an automated way 

@depends : https://github.com/aurelien-andre-weldom/ops-debian

### Terraform Versions

```json
{
  "8.1": {
    "variants": [
      "100.0.1-bullseye/cli",
      "100.0.1-bullseye/fpm",
      "100.0.0-bullseye/cli",
      "100.0.0-bullseye/fpm"
    ],
    "version": "8.1"
  }
}

```

### Usage

Edit dockerfile.template

```shell
# Update all versions
MASTER_VERSION=8.1 \
MASTER_SUITE=100.0.1-bullseye \
bash run-update.sh
```

```shell
# Build all docker images
MASTER_VERSION=8.1 \
MASTER_SUITE=100.0.1-bullseye \
bash run-build.sh
```

### Env Configuration

PHP

```dotenv
PHP_MEMORY_LIMIT="4G"
PHP_REALPATH_CACHE_SIZE="4096K"
PHP_REALPATH_CACHE_TTL="600"
PHP_SENDMAIL_PATH=""
PHP_XDEBUG__MODE="off"
PHP_XDEBUG__CLIENT_PORT="9003"
PHP_XDEBUG__CLIENT_HOST="172.17.0.1"
PHP_XDEBUG__IDEKEY="PHPSTORM"
PHP_OPCACHE__ENABLE="0"
PHP_OPCACHE__ENABLE_CLI="0"
PHP_OPCACHE__MEMORY_CONSUMPTION="256"
PHP_OPCACHE__INTERNED_STRINGS_BUFFER="8"
PHP_OPCACHE__MAX_ACCELERATED_FILES="60000"
PHP_OPCACHE__MAX_WASTED_PERCENTAGE="5"
PHP_OPCACHE__USE_CWD="1"
PHP_OPCACHE__VALIDATE_TIMESTAMPS="0"
PHP_OPCACHE__REVALIDATE_FREQ="2"
PHP_OPCACHE__REVALIDATE_PATH="0"
PHP_OPCACHE__SAVE_COMMENTS="1"
PHP_OPCACHE__RECORDS_WARNING="0"
PHP_OPCACHE__ENABLE_FILE_OVERRIDE="0"
PHP_OPCACHE__OPTIMIZATION_LEVEL="0x7FFFBFFF"
PHP_OPCACHE__DUPS_FIX="0"
PHP_OPCACHE__BLACKLIST_FILENAME="/etc/php/{{ env.version }}/opcache-*.blacklist"
PHP_OPCACHE__MAX_FILE_SIZE="0"
PHP_OPCACHE__CONSISTENCY_CHECKS="0"
PHP_OPCACHE__FORCE_RESTART_TIMEOUT="180"
PHP_OPCACHE__ERROR_LOG="/var/log/opcache"
PHP_OPCACHE__LOG_VERBOSITY_LEVEL="1"
PHP_OPCACHE__PREFERRED_MEMORY_MODEL=""
PHP_OPCACHE__PROTECT_MEMORY="0"
PHP_OPCACHE__RESTRICT_API=""
PHP_OPCACHE__MMAP_BASE=""
PHP_OPCACHE__CACHE_ID=""
PHP_OPCACHE__FILE_CACHE="/var/cache/opcache"
PHP_OPCACHE__FILE_CACHE_ONLY="0"
PHP_OPCACHE__FILE_CACHE_CONSISTENCY_CHECKS="1"
PHP_OPCACHE__FILE_CACHE_FALLBACK="1"
PHP_OPCACHE__HUGE_CODE_PAGE="1"
PHP_OPCACHE__VALIDATE_PERMISSION="0"
PHP_OPCACHE__VALIDATE_ROOT="0"
PHP_OPCACHE__OPT_DEBUG_LEVEL="0"
PHP_OPCACHE__PRELOAD=""
PHP_OPCACHE__PRELOAD_USER="rootless"
PHP_OPCACHE__LOCKFILE_PATH="/var/lock/opcache"
PHP_OPCACHE__JIT="1255"
PHP_OPCACHE__JIT_BUFFER_SIZE="400MB"
```

FPM 

```dotenv
FPM_PID="/var/pid/php{{ env.version }}-fpm.pid"
FPM_ERROR_LOG="/proc/self/fd/1"
FPM_LISTENER="/var/run/php{{ env.version }}-fpm.sock"
FPM_PM="ondemand"
FPM_PM_MAX_CHILDREN="5"
FPM_PM_START_SERVERS="2"
FPM_PM_MIN_SPARE_SERVERS="1"
FPM_PM_MAX_SPARE_SERVERS="3"
FPM_PM_PROCESS_IDLE_TIMEOUT="10s;"
FPM_PM_MAX_REQUESTS="500"
```
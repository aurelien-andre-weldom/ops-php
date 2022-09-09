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

**PHP**

```dotenv
PHP_MEMORY_LIMIT=4G
```

```ini
# cat /etc/php/{{ env.version }}/99-php.ini
memory_limit = __PHP_MEMORY_LIMIT__
```

**FPM** 

```dotenv
FPM_PM="ondemand"
FPM_PM_MAX_CHILDREN="5"
FPM_PM_START_SERVERS="2"
FPM_PM_MIN_SPARE_SERVERS="1"
FPM_PM_MAX_SPARE_SERVERS="3"
FPM_PM_PROCESS_IDLE_TIMEOUT="10s"
FPM_PM_MAX_REQUESTS="500"
```

### Test

CLI

```shell
docker run -it --rm --name ops-php ops-php/php:cli-latest php --version
```

FPM

```shell
docker run -it --rm --name ops-php -p 9001:9001 ops-php/php:fpm-latest
```

@see http://localhost:9001
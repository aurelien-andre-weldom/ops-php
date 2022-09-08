# OPS Linux

Create your php templates in an automated way 

@depends : https://github.com/aurelien-andre-weldom/ops-linux

### Terraform Versions

```json
{
  "8.1": {
    "variants": [
      "100.0.1-bullseye/cli",
      "100.0.1-bullseye/fpm",
      "100.0.1-buster/cli",
      "100.0.1-buster/fpm",
      "100.0.0-bullseye/cli",
      "100.0.0-bullseye/fpm",
      "100.0.0-buster/cli",
      "100.0.0-buster/fpm"
    ],
    "version": "8.1"
  },
  "7.4": {
    "variants": [
      "100.0.1-bullseye/cli",
      "100.0.1-bullseye/fpm",
      "100.0.1-buster/cli",
      "100.0.1-buster/fpm",
      "100.0.0-bullseye/cli",
      "100.0.0-bullseye/fpm",
      "100.0.0-buster/cli",
      "100.0.0-buster/fpm"
    ],
    "version": "7.4"
  }
}
```

### Requirements

```shell
# Install JQ
sudo apt-get install jq
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

```dotenv

```

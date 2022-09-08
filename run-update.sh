#!/bin/bash
set -Eeuo pipefail

# wget -qO ".jq-template.awk" 'https://github.com/docker-library/bashbrew/raw/9f6a35772ac863a0241f147c820354e4008edf38/scripts/jq-template.awk'

[ -f versions.json ] # run "versions.sh" first

jqt='.jq-template.awk'

if [ "$#" -eq 0 ]; then

  versions="$(jq -r 'keys | map(@sh) | join(" ")' versions.json)"

  eval "set -- $versions"

fi

generated_warning() {
	cat <<-EOH
#
# OPS PHP
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
# @see https://github.com/aurelien-andre-weldom/ops-php
#
	EOH
}

rm -rf "image"

for version; do

  export version

  variants="$(jq -r '.[env.version].variants | map(@sh) | join(" ")' versions.json)"

  eval "variants=( $variants )"

  for dir in "${variants[@]}"; do

    suite="$(dirname "$dir")"

    variant="$(basename "$dir")"

    export suite variant

    from="ops-linux/debian:$suite"

    export from

    mkdir -p "image/$version/$suite/$variant"

    echo "processing ops-php/php:$version-$suite-$variant ..."

    {
      generated_warning

      gawk -f "$jqt" 'dockerfile.template'

    } > "image/$version/$suite/$variant/Dockerfile"

    mkdir -p "image/$version/$suite/$variant/system/etc/php/$version"

    cp -a system/etc/php/version/* "image/$version/$suite/$variant/system/etc/php/$version"

    mkdir -p "image/$version/$suite/$variant/system/usr/bin"

    cp -a system/usr/bin/* "image/$version/$suite/$variant/system/usr/bin"

    if [ "$variant" == "cli" ]; then

      rm -rf "image/$version/$suite/$variant/system/usr/bin/docker-entrypoint-php-fpm.sh"

      rm -rf "image/$version/$suite/$variant/system/etc/php/$version/fpm"

    fi

    if [ "$variant" == "fpm" ]; then

      mkdir -p "image/$version/$suite/$variant/system/etc/supervisor/conf.d"

      cp -a system/etc/supervisor/* "image/$version/$suite/$variant/system/etc/supervisor"

    fi

  done

done

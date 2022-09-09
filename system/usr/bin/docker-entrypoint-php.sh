#!/bin/bash
set -e

if [ ! -s "/etc/php/version/99-php.ini" ]; then

  for e in "${!PHP_@}"; do

    VARIABLE=$(echo "$e" | sed -e 's/PHP_/''/g' | sed -e 's/__/'.'/g' | awk '{print tolower($0)}')

    VALUE=$(printf '${%s}' "$e")

    echo "$VARIABLE=$VALUE" >> "/etc/php/version/99-php.ini"

  done

fi

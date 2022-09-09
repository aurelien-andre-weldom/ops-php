#!/bin/bash
set -e

files="
/etc/php/version/99-php.ini
"

for file in $files; do

  if [ -f "$file" ]; then

    for e in "${!PHP_@}"; do

        sed -i -e 's!__'"$e"'__!'"$(printenv "$e")"'!g' "$file"

    done

  fi

done

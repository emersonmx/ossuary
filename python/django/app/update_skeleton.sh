#!/bin/bash

set -euf -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

django_version="4.2"
tmp_dir=$(mktemp -d)

camel_case_app_name='{{ skelly.app_name | replace(from="_", to=" ") | title | split(pat=" ") | join }}'

git clone --depth 1 --branch "stable/${django_version}.x" https://github.com/django/django "$tmp_dir"
template_dir="$tmp_dir/django/conf/app_template"
files=$(find "$template_dir" -type f -iname "*-tpl")
for f in $files
do
    # File changes
    if [[ $f == *"apps.py-tpl" ]]; then
        sed -r \
            -e "s/^(.* = )'(.*)'$/\1\"\2\"/" \
            -i "$f"
    fi

    # Add skelly prefix
    sed -r \
        -e 's/\{\{ (.*) \}\}/{{ skelly.\1 }}/g' \
        -e 's/\{\{ skelly.camel_case_app_name \}\}/'"$camel_case_app_name"'/g' \
        -i "$f"
    mv "$f" "${f%'-tpl'}"
done

rm -rf "$script_dir/skeleton"
mkdir -p "$script_dir/skeleton"
mv "$template_dir" "$script_dir/skeleton/{{ skelly.app_name }}"

rm -rf "$tmp_dir"

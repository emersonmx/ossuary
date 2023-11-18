#!/bin/bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 <version>"
    exit 1
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

tmp_dir=$(mktemp -d)
version="$1"
camel_case_app_name='{{ skelly.app_name | replace(from="_", to=" ") | title | split(pat=" ") | join }}'

git clone --depth 1 --branch "stable/${version}.x" https://github.com/django/django "$tmp_dir"
template_dir="$tmp_dir/django/conf/app_template"
files=$(find "$template_dir" -type f -iname "*-tpl")
for f in $files
do
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

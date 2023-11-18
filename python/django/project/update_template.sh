#!/bin/bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 <version>"
    exit 1
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

tmp_dir=$(mktemp -d)
version="$1"

git clone --depth 1 --branch "stable/${version}.x" https://github.com/django/django "$tmp_dir"
template_dir="$tmp_dir/django/conf/project_template"
files=$(find "$template_dir" -type f -iname "*-tpl")
for f in $files
do
    sed -r \
        -e 's/\{\{ docs_version \}\}/'"${version}"'/g' \
        -e 's/\{\{ (.*) \}\}/{{ skelly.\1 }}/g' -i "$f"
    mv "$f" "${f%'-tpl'}"
done

rm -rf "$script_dir/skeleton"
mkdir -p "$script_dir/skeleton"
mv "$template_dir/project_name" "$template_dir/{{ skelly.project_name }}"
mv "$template_dir" "$script_dir/skeleton/{{ skelly.project_name }}}"

rm -rf "$tmp_dir"

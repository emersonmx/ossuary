#!/bin/bash

set -euf -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

python_version="py311"
django_version="5.0"
tmp_dir=$(mktemp -d)

# replace strings
secret_key_replace='os.environ["SECRET_KEY"]'
allowed_hosts_replace='ALLOWED_HOSTS = list(filter(bool, os.environ.get("ALLOWED_HOSTS", "").split(",")))'

git clone --depth 1 --branch "stable/${django_version}.x" https://github.com/django/django "$tmp_dir"
template_dir="$tmp_dir/django/conf/project_template"
files=$(find "$template_dir" -type f -iname "*-tpl")
for f in $files
do
    # File changes
    if [[ $f == *"settings.py-tpl" ]]; then
    sed -r \
        -e '/^from pathlib import Path$/iimport os' \
        -e "s/'\{\{ secret_key \}\}'/""${secret_key_replace}"'/' \
        -e 's/^DEBUG = True$/DEBUG = os.environ.get("DEBUG", False)/' \
        -e 's/^ALLOWED_HOSTS = \[\]$/'"${allowed_hosts_replace}"'/' \
        -i "$f"
    fi

    # Remove unused variables
    sed -r \
        -e 's/\{\{ docs_version \}\}/'"${django_version}"'/g' \
        -e 's/\{\{ django_version \}\}/'"${django_version}"'/g' \
        -i "$f"

    mv "$f" "${f%'-tpl'}"
done

rm -rf "$script_dir/skeleton"
mv "$template_dir/project_name" "$template_dir/{{ project_name }}"
mv "$template_dir" "$script_dir/skeleton"

rm -rf "$tmp_dir"

ruff format \
    --target-version ${python_version} \
    --line-length 80 \
    skeleton/
ruff check \
    --fix \
    --target-version ${python_version} \
    --select UP,I,COM,E,W \
    --ignore E501 \
    skeleton/
ruff format \
    --target-version ${python_version} \
    --line-length 80 \
    skeleton/

#!/usr/bin/env bash

add_line=""
if [ -s pyproject.toml ]; then
    add_line=$'\n'
fi

cat >>pyproject.toml <<EOF
${add_line}$(skf ruff/base)

$(skf ruff/lint)
EOF

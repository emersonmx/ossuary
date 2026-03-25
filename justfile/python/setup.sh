#!/usr/bin/env bash

cat >justfile <<EOF
$(skf justfile/python/sync)

$(skf justfile/python/run command=./main.py)

$(skf justfile/python/format)

$(skf justfile/python/lint)

$(skf justfile/python/test)

$(skf justfile/python/clean)
EOF

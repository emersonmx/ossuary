#!/usr/bin/env bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

$(skf editorconfig/makefile)

$(skf editorconfig/markdown)

$(skf editorconfig/html)

$(skf editorconfig/yaml)
EOF

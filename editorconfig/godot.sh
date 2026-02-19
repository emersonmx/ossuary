#!/usr/bin/env bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

[*.gd]
indent_style = tab

$(skf editorconfig/markdown)
EOF

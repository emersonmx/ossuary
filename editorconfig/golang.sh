#!/usr/bin/env bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

[*.go]
indent_style = tab

$(skf editorconfig/markdown)
EOF

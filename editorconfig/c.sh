#!/usr/bin/env bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

$(skf editorconfig/makefile)

$(skf editorconfig/markdown)
EOF

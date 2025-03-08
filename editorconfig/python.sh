#!/bin/bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

$(skf editorconfig/makefile)

$(skf editorconfig/markdown)

$(skf editorconfig/yaml)
EOF

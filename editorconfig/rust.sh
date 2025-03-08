#!/bin/bash

cat >.editorconfig <<EOF
$(skf editorconfig/base)

$(skf editorconfig/markdown)
EOF
